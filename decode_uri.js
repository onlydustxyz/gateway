function decode_ddforward_uri(r) {
  var decodedDdForward = decodeURI(r.args.ddforward);
  return decodedDdForward.split("?")[0];
}

function decode_ddforward_args(r) {
  var decodedDdForward = decodeURI(r.args.ddforward);
  return encodeURI(decodedDdForward.split("?")[1]);
}

export default { decode_ddforward_uri, decode_ddforward_args };
