pragma circom 2.0.8;

template mul() {
    signal input a;
    signal input b;
    signal output out;
    out <== a * b;
}

template pow(N) {
   signal input in;
   signal output out;
   component comp[N-1];

   for(var i = 0; i < N - 1; i++){
       comp[i] = mul();
   }
   comp[0].a <== in;
   comp[0].b <== in;
   for(var i = 0; i < N - 2; i++){
       comp[i+1].a <== comp[i].out;
       comp[i+1].b <== in;
   }
   out <== comp[N-2].out;
}

template paillier() {
    signal input g;
    signal input m;
    signal output out;

    component gPowMessage = pow(150);
    gPowMessage.in <== g;
    out <== gPowMessage.out;
}

component main = paillier();
