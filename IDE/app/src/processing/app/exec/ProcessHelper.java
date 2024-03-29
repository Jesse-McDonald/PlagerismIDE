/* -*- mode: java; c-basic-offset: 2; indent-tabs-mode: nil -*- */
/*
 Part of the Processing project - http://processing.org

 Copyright (c) 2009-10 Ben Fry and Casey Reas

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2
 as published by the Free Software Foundation.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software Foundation,
 Inc., 59 Temple Place, Suite 330, Boston, MA	02111-1307	USA
 */
package processing.app.exec;

import java.io.*;

import processing.core.PApplet;

/**
 * Class to handle calling Runtime.exec() and stuffing output and error streams
 * into Strings that can be dealt with more easily.
 *
 * @author Jonathan Feinberg <jdf@pobox.com>
 */
public class ProcessHelper {
	private final String[] cmd;
//	private final String exe;
//	private final String[] args;
	private final File dir;


	public ProcessHelper(final String... cmd) {
		this.cmd = cmd;
		this.dir = null;
	}

	
	public ProcessHelper(File dir, final String... cmd) {
		this.cmd = cmd;
		this.dir = dir;
	}
	

	@Override
	public String toString() {
		return PApplet.join(cmd, " ");
	}

	
	/**
	 * Blocking execution.
	 * @return exit value of process
	 * @throws InterruptedException
	 * @throws IOException
	 */
	public ProcessResult execute() throws InterruptedException, IOException {
		return execute(null);
	}
	
	
	/**
	 * Blocks execution, also passes a single line to the command's input stream.
	 * @return exit value of process
	 * @throws InterruptedException
	 * @throws IOException
	 */
	public ProcessResult execute(String outgoing) throws InterruptedException, IOException {
		final StringWriter outWriter = new StringWriter();
		final StringWriter errWriter = new StringWriter();
		final long startTime = System.currentTimeMillis();

		final String prettyCommand = toString();
		//		System.err.println("ProcessHelper: >>>>> " + Thread.currentThread().getId()
		//				+ " " + prettyCommand);
//		final Process process = Runtime.getRuntime().exec(cmd);
		final Process process = dir == null ? 
			Runtime.getRuntime().exec(cmd) :
			Runtime.getRuntime().exec(cmd, new String[] { }, dir);
		ProcessRegistry.watch(process);
		
		// Write a single line of output to the app... used to write 'no' to 'create avd'
		if (outgoing != null) {
			OutputStream os = process.getOutputStream();
			PrintWriter pw = new PrintWriter(new OutputStreamWriter(os));
			pw.println(outgoing);
			pw.flush();
			pw.close();
		}

		try {
			String title = prettyCommand;
			new StreamPump(process.getInputStream(), "out: " + title).addTarget(outWriter).start();
			new StreamPump(process.getErrorStream(), "err: " + title).addTarget(errWriter).start();
			try {
				final int result = process.waitFor();
				final long time = System.currentTimeMillis() - startTime;
				//				System.err.println("ProcessHelper: <<<<< "
				//						+ Thread.currentThread().getId() + " " + cmd[0] + " (" + time
				//						+ "ms)");
				return new ProcessResult(prettyCommand, result, outWriter.toString(),
																 errWriter.toString(), time);
			} catch (final InterruptedException e) {
				System.err.println("Interrupted: " + prettyCommand);
				throw e;
			}
		} finally {
			process.destroy();
			ProcessRegistry.unwatch(process);
		}
	}
	
	
	static public boolean ffs(final String... cmd) {
		try {
			ProcessHelper helper = new ProcessHelper(cmd);
			ProcessResult result = helper.execute();
			if (result.succeeded()) {
				return true;
			}
			System.out.println(result.getStdout());
			System.err.println(result.getStderr());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
