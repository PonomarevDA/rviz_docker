#!/usr/bin/env python3
# This program is free software under the GNU General Public License v3.
# See <https://www.gnu.org/licenses/> for details.
# Author: Dmitry Ponomarev <ponomarevda96@gmail.com>

import os
import sys

try:
    import gdown
except ImportError:
    print(
        "Error: The 'gdown' package is not installed.\n"
        "You can install it using pip:\n\n"
        "    pip install gdown\n\n"
    )
    sys.exit(1)

BASE_DIR = "models"

models = [
    {'id': "18fdSsnKvbXQLqfWb_mu2Q4eAavGvjkp5", 'name': "hany"},
    {'id': "1FlVgel2l5BrOxK1F-FImBssBnTdTcWQQ", 'name': "cyphaldrone"},
    {'id': "1lYfGu8VphDPBk_AMisGUksshFAxrHp6s", 'name': "vtol_2000"},
    {'id': "1KFJPLZ2HDexYuSb9L-BMWA85fPgO6cDJ", 'name': "vtol_3000"},
    {'id': "10Y5h9x0nrM3psSgvUAHdP9cvazyc2iEW", 'name': "vtol_T_300", 'extension': 'fbx'},
    {'id': "1pkdN_nAFF8ERSHR08zefVz2T8kBUulJL", 'name': "vtol_TFM_15", 'extension': 'fbx'},
]

def download_model_from_google_drive(model_id, model_name, file_path):
    if os.path.exists(file_path):
        print(f"Skipping {model_name}, file already exists at {file_path}.")
        return

    url = f"https://drive.google.com/uc?id={model_id}"

    print(f"Downloading {model_name} model...")
    try:
        gdown.download(url, file_path, quiet=False)
        print(f"Model {model_name} saved to {file_path}")
    except Exception as e:
        print(f"Failed to download {model_name}. Error: {e}")


os.makedirs(BASE_DIR, exist_ok=True)
for model in models:
    model_id = model['id']
    model_name = model['name']
    extension = model.get('extension', 'stl')
    model_dir = os.path.join(BASE_DIR, model_name)

    os.makedirs(model_dir, exist_ok=True)
    file_path = os.path.join(model_dir, f"vehicle.{extension}")
    download_model_from_google_drive(model_id, model_name, file_path)
