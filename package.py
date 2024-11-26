name = "osl"

version = "1.13.11.0"

authors = [
    "Sony Pictures Imageworks"
]

description = \
    """
    Open Shading Language (OSL) is a small but rich language for programmable shading in advanced renderers and
    other applications, ideal for describing materials, lights, displacement, and pattern generation.
    """

requires = [
    "bison",
    "boost",
    "cmake",
    "flex",
    "gcc-6+",
    "ilmbase-2.2+<2.4",
    "llvm-5+",
    "oiio",
    "openexr-2",
    "partio-1+",
    "png-1.6+",
    "pugixml-1+",
]

variants = [
    ["platform-linux","arch-x86_64"]
]

tools = [
    "oslc",
    "oslinfo",
    "testrender",
    "testshade",
    "testshade_dso",
]

build_system = "cmake"

with scope("config") as config:
    config.build_thread_count = "logical_cores"

uuid = "osl-{version}".format(version=str(version))

def commands():
    env.PATH.prepend("{root}/bin")
    env.LD_LIBRARY_PATH.prepend("{root}/lib64")

    # Helper environment variables.
    env.OSL_BINARY_PATH.set("{root}/bin")
    env.OSL_INCLUDE_PATH.set("{root}/include")
    env.OSL_LIBRARY_PATH.set("{root}/lib64")
