import os
import cv2
import pathlib
import argparse


def extract_frames(video_path, output_dir_path):

    if not os.path.exists(output_dir_path):
        os.makedirs(output_dir_path, exist_ok=True)

    capture = cv2.VideoCapture(video_path)
    if not capture.isOpened():
        return

    frame = 0
    while True:
        result, image = capture.read()
        if not result:
            break

        output_file_name = f"frame_{frame}.jpg"
        output_file_path = os.path.join(output_dir_path, output_file_name)
        cv2.imwrite(output_file_path, image)
        frame += 1


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("video_path", type=pathlib.Path)
    parser.add_argument("output_dir_path", type=pathlib.Path)
    args = parser.parse_args()
    extract_frames(str(args.video_path), str(args.output_dir_path))


if __name__ == "__main__":
    main()
