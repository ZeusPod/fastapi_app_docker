from typing import Union
from fastapi import FastAPI, Response
from weasyprint import HTML

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}

@app.get("/print_pdf")
def print_pdf():
    html_content = """
    <html>
        <head>
            <title>Example PDF</title>
        </head>
        <body>
            <h1>Esto es un ejemplo de PDF con WeasyPrint</h1>
            <p>Este PDF es generado usando WeasyPrint en un FastAPI, Docker y Render.com</p>
        </body>
    </html>
    """
    pdf = HTML(string=html_content).write_pdf()
    return Response(content=pdf, media_type="application/pdf")
