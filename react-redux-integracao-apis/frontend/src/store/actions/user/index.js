export function submitUserAction(data) {
  console.log(data);
  fetch("http://localhost:8080/usuario", {
    method: "POST",
    headers: {
      'Content-type': 'application/json'
    },
    body: JSON.stringify(data)
  }).then(response => response.json()).then(json => console.log(json))
}