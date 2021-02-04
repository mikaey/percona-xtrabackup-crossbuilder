# Percona Xtrabackup Crossbuilder

This Docker image builds a copy of Percona Xtrabackup 8.0.22-15 for Ubuntu Focal. This was originally built
to target the arm64 platform, but it should be usable on other platforms as well (as long as it's supported
by buildx). It utilizes the target system's compiler, libraries, and toolchain, and uses QEMU to emulate
the compiler (so the build process is going to be pretty slow).  It spits out a set of completed Debian
packages that can be directly installed on the target system.

## How to build

You will need to have either a copy of Docker that supports [buildx](https://docs.docker.com/buildx/working-with-buildx/)
or you'll need to [download a buildx binary](https://github.com/docker/buildx/releases).

`cd` into the repo directory and build with `docker buildx build --platform <platform>`, where `<platform>`
is one of the platforms supported by buildx (such as `linux/arm64`, `linux/arm/v7`, `linux/arm/v6`, etc.).

## How to run

1. Create a directory called `output` (or call it something else, I'm not your mother).
2. Run `docker run -v ${PWD}/output:/output <image_id>`, where `<image_id>` is the image ID that was spit
out above. If you went against my advice and named your output folder something other than `output`,
change `${PWD}/output` to the absolute path to your output folder.
3. Wait for the build to finish.  (It'll take a while -- it takes several hours on my hardware.)  Once the
build is finished, find the completed packages in the output folder.

## Notes

1. The build process itself should only take a few minutes, but the actual run will take a while. Make sure
you're running it on a system with plenty of RAM and disk space available.  On my hardware (Linux with
2x Intel Xeon 5140's), the build process takes several hours, probably 8GB-10GB of physical RAM, and
probably 16GB of disk space.
2. This image downloads the source archives directly from Percona's site. It's about 281 MB and there's no
status display while it's downloading...so you're probably going to see "Fetching source archive..."
followed by several minutes of nothing. Be patient!

