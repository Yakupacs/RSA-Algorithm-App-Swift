<h1 align="center">
     RSA ALGORITHM APP SWIFT
</h1>

# Description
###### RSA (Rivest–Shamir–Adleman) is a public-key cryptosystem that is widely used for secure data transmission. The security of RSA relies on the practical difficulty of factoring the product of two large prime numbers, the "factoring problem". Breaking RSA encryption is known as the RSA problem. Whether it is as difficult as the factoring problem is an open question.[3] There are no published methods to defeat the system if a large enough key is used.

# The Algorithm
```
For example, suppose the receiver selected the primes p=11 and q=17, along with e=3.

The receiver calculates n = p * q = 11 * 17 = 187 n = p * q = 11 * 17 = 187, which is half of the public key.
The receiver also calculates ϕ(n)=(p-1)(q-1)=10 * 16=160 ϕ(n)=(p−1)(q−1)=10⋅16=160. e = 3 was also chosen.
The receiver calculates d = 107, since then de = 321 \equiv 1 \pmod{{\small\phi(n)}}de=321≡1(modϕ(n)) \big((since \phi(n)=160).ϕ(n)=160).
The receiver distributes his public key: n=187n=187 and e=3e=3.
Now suppose the sender wanted to send the message "HELLO". Since nn is so small, the sender will have to send his message character by character.

'H' is 72 in ASCII, so the message text is m=72m=72.
The sender calculates m^e=72^3 \equiv 183 \pmod{187}m 
e = 72 
3 ≡ 183 (mod 187), making the ciphertext c=183c=183. Again, this is the only information an attacker can get, since the attacker does not have the private key.
The receiver calculates c^d=183^{107} \equiv 72 \pmod{187}c 
d = 183 
107 ≡ 72 (mod 187), thus getting the message of m=72.
The receiver translates 72 into 'H'.
The rest of the letters are sent in the same way.
```


--------
# Photo

<img width=200 src="https://user-images.githubusercontent.com/73075252/209012216-a326a315-e625-4726-b8f9-2076e4423322.png">
<img width=200 src="https://user-images.githubusercontent.com/73075252/209012342-175022b1-85d8-4d2e-bd38-e052f2803065.png">
<img width="200" src="https://user-images.githubusercontent.com/73075252/209012430-481481f1-6966-47d4-a9a0-bf0e24b23c6e.png">
<img width="200" src="https://user-images.githubusercontent.com/73075252/209012500-6c696eb0-4c31-4b59-ac94-b234a6c682bc.png">
