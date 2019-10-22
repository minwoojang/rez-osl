name = "osl"

version = "1.10.7"

authors = [
    "Sony Pictures Imageworks"
]

description = \
    """
    Open Shading Language (OSL) is a small but rich language for programmable shading in advanced renderers and
    other applications, ideal for describing materials, lights, displacement, and pattern generation.
    """

requires = [
    "bison-3+",
    "boost-1.55+",
    "cmake-3+",
    "flex-2+",
    "gcc-6+",
    "ilmbase-2.2+<2.4",
    "llvm-5+",
    "oiio-1.8.5+",
    "openexr-2.2+<2.4",
    "partio-1+",
    "png-1.6+",
    "pugixml-1+",
]

variants = [
    ["platform-linux"]
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
