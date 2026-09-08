from pathlib import Path
from uuid import uuid4


project_file = Path("Project.toml")
project = project_file.read_text()
project_file.write_text(
    project.replace("00000000-0000-0000-0000-000000000000", str(uuid4()))
)
