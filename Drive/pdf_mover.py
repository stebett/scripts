#!/usr/bin/env python3

import os

path_ = '/home/ginko/Documents/Note/'
new_path = '/home/ginko/Documents/Note/Sync/Appunti/'

subjects = ['Dinamica/']


def main(subject, path=path_):
    note_dirs = os.listdir(path + subject)
    all_files = [os.listdir(path + subject + i) for i in note_dirs]

    flat_all_files = []

    for sublist in all_files:
        for item in sublist:
            flat_all_files.append(item)

            pdf_files = []

            for i in flat_all_files:
                if '.pdf' in i:
                    pdf_files.append(i)

    for pdf in pdf_files:
        pdf_path = path + subject + pdf[:-4] + '/' + pdf

        os.replace(pdf_path, new_path + subject + pdf)


if __name__ == '__main__':
    for subj in subjects:
        main(subj)
