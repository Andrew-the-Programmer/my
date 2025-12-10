"""Compress video file to target size"""

import argparse
import os
import subprocess
from pathlib import Path
from typing import TypeAlias

from humanfriendly import parse_size

# Type aliases for clarity
intMegabytes: TypeAlias = int
intBits: TypeAlias = int


def compress_video(input_file: Path, output_file: Path, target_size: intBits):
    """
    Compress video to fit within a target size range

    Args:
        input_file: Path to input video file
        output_file: Path for output compressed video
        target_size_mb_min: Minimum target size in MB
        target_size_mb_max: Maximum target size in MB
    """

    # Check if input file exists
    if not input_file.exists():
        raise FileNotFoundError(f"Input file {input_file} does not exist")

    # Get video duration in seconds
    try:
        result = subprocess.run(
            [
                "ffprobe",
                "-v",
                "error",
                "-show_entries",
                "format=duration",
                "-of",
                "default=noprint_wrappers=1:nokey=1",
                input_file,
            ],
            capture_output=True,
            text=True,
            check=True,
        )
        duration = float(result.stdout.strip())
    except (subprocess.CalledProcessError, ValueError):
        raise RuntimeError("Could not get video duration")

    # Calculate target bitrate (use midpoint of range)
    target_size_bits = target_size
    target_bitrate = int(target_size_bits / duration)  # bits per second

    # Compress video
    try:
        subprocess.run(
            [
                "ffmpeg",
                "-i",
                input_file,
                "-c:v",
                "libx264",
                "-b:v",
                f"{target_bitrate}",
                "-pix_fmt",
                "yuv420p",
                "-preset",
                "medium",
                "-crf",
                "23",
                "-c:a",
                "aac",
                "-b:a",
                "128k",
                "-y",  # Overwrite output file
                output_file,
            ],
            check=True,
            capture_output=True,
        )

        print(f"Video compressed successfully: {output_file}")

        # Check final file size
        final_size_mb = os.path.getsize(output_file) / (1024 * 1024)
        print(f"Final size: {final_size_mb:.2f} MB")

        return output_file

    except subprocess.CalledProcessError as e:
        raise RuntimeError(f"FFmpeg compression failed: {e}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Compress video file to target size",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s input.mp4 --output-path output.mp4 --size 10
  %(prog)s /path/to/video.mov -s 20
""",
    )

    parser.add_argument("input_path", help="Path to input video file", type=Path)
    parser.add_argument(
        "-o",
        "--output-path",
        type=Path,
        required=False,
        help="Path for output compressed video",
    )
    parser.add_argument(
        "-s",
        "--size",
        required=True,
        help="Target size range in MB (format: min-max, e.g., 5-10)",
    )

    args = parser.parse_args()

    """Main function"""
    target_size: intBits = parse_size(args.size, binary=True) * 8

    if args.output_path is None:
        args.output_path = args.input_path

    print(f"Input: {args.input_path}")
    print(f"Output: {args.output_path}")
    print(f"Target size: {args.size}")
    print("-" * 50)

    # Compress video
    compress_video(
        input_file=args.input_path,
        output_file=args.output_path,
        target_size=target_size,
    )
