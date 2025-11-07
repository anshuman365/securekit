from setuptools import setup, find_packages

setup(
    name="securekit",
    version="1.0.2",
    packages=find_packages(where="src"),
    package_dir={"": "src"},
    install_requires=[
        "argon2-cffi>=21.3.0",
        "cryptography>=41.0.0",
        "pynacl>=1.5.0",
    ],
    extras_require={
        "aws": ["boto3>=1.26.0"],
        "vault": ["hvac>=1.0.0"],
        "django": ["Django>=3.2.0"],
        "flask": ["Flask>=2.0.0"],
        "fastapi": ["fastapi>=0.68.0", "uvicorn>=0.15.0"],
        "dev": [
            "pytest>=6.0",
            "pytest-cov>=2.0",
            "black>=22.0",
            "isort>=5.0",
            "mypy>=0.910",
        ],
    },
    entry_points={
        "console_scripts": [
            "securekit=securekit.cli.main:cli",
        ],
    },
)