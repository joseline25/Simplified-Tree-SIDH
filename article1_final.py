#!/usr/bin/env python
# coding: utf-8

# In[74]:


n_A = 216
n_B = 137
l_A = 2
l_B = 3
n_A, n_B, l_A, l_B


# In[75]:


p = l_A^n_A * l_B^n_B -1
p, is_prime(p)


# In[76]:


F.<i> = GF(p^2, modulus=x^2+1)
F


# In[77]:


E = EllipticCurve(F, [0, 6, 0, 1, 0])
p, F, E, E.is_supersingular()


# In[78]:


def isogeny_walk (E,R,l, a):
    Ei, Ri = E, R
    Phi = E.isogeny(E(0))
    for j in (a-1, a-2 .. 0):
         R1 = l^j * Ri
         phi = Ei.isogeny(R1)
         Phi = phi*Phi
         Ei = phi.codomain()
         Ri = phi(Ri)
    return Phi


# In[79]:


# un point de l_A^n_A = 2^216-torsion sur E
P0 = E(0)
while (2^(n_A - 1))*P0 == 0:
    P0 = l_B^n_B*E.random_point()
P0, P0.order() == l_A^n_A


# In[80]:


Q0 = P0
while P0.weil_pairing(Q0, l_A^n_A)^(l_A^(n_A - 1)) == 1:
    Q0 = l_B^n_B* E.random_point()
Q0, Q0.order() == l_A^n_A


# In[81]:


# un point de l_B^n_B = 3^137-torsion sur E
P1 = E(0)
while (3^(n_B - 1))*P1 == 0:
    P1 = l_A^n_A*E.random_point()
P1, P1.order() == l_B^n_B


# In[82]:


Q1 = P1
while P1.weil_pairing(Q1, l_B^n_B)^(l_B^(n_B - 1)) == 1:
    Q1 = l_A^n_A* E.random_point()
Q1, Q1.order() == l_B^n_B


# In[83]:


S3 = randint(0, l_B^n_B - 1)
S5 = randint(0, l_B^n_B - 1)
R3 = P1 + S3 * Q1
R5 = P1 + S5 * Q1
R3, R3.order() == l_B^n_B, R5, R5.order() == l_B^n_B


# In[84]:


Phi3 = isogeny_walk (E, R3, l_B, n_B)
Phi3


# In[85]:


Phi5 = isogeny_walk (E, R5, l_B, n_B)
Phi5


# In[86]:


S4 = randint(0, l_A^n_A - 1)
S6 = randint(0, l_A^n_A - 1)
R4 = P0 + S4 * Q0
R6 = P0 + S6 * Q0
R4, R4.order() == l_A^n_A, R6, R6.order() == l_A^n_A


# In[87]:


Phi4 = isogeny_walk (E, R4, l_A, n_A)
Phi4


# In[88]:


Phi6 = isogeny_walk (E, R6, l_A, n_A)
Phi6


# In[89]:


E3 = Phi3.codomain()
E4 = Phi4.codomain()
E5 = Phi5.codomain()
E6 = Phi6.codomain()
E3, E4, E5, E6


# In[90]:


Phi3_P0, Phi3_Q0  = Phi3(P0), Phi3(Q0)
Phi3_P0, Phi3_Q0


# In[91]:


Phi5_P0, Phi5_Q0  = Phi5(P0), Phi5(Q0)
Phi5_P0, Phi5_Q0


# In[92]:


Phi4_P1, Phi4_Q1  = Phi4(P1), Phi4(Q1)
Phi4_P1, Phi4_Q1


# In[93]:


Phi6_P1, Phi6_Q1  = Phi6(P1), Phi6(Q1)
Phi6_P1, Phi6_Q1


# In[94]:


Phi34 = isogeny_walk(E4, Phi4_P1 + S3 * Phi4_Q1, l_B,n_B)
Phi34


# In[95]:


Phi43 = isogeny_walk(E3, Phi3_P0 + S4 * Phi3_Q0, l_A,n_A)
Phi43


# In[96]:


E34 = Phi34.codomain()
E34, E34.j_invariant()


# In[97]:


E43 = Phi43.codomain()
E43,  E43.j_invariant()


# In[98]:


E34.j_invariant() == E43.j_invariant()


# In[99]:


Phi56 = isogeny_walk(E6, Phi6_P1 + S5 * Phi6_Q1, l_B,n_B)
Phi56


# In[100]:


Phi65 = isogeny_walk(E5, Phi5_P0 + S6 * Phi5_Q0, l_A,n_A)
Phi65


# In[101]:


E56 = Phi56.codomain()
E56, E56.j_invariant()


# In[102]:


E65 = Phi65.codomain()
E65, E65.j_invariant()


# In[103]:


E56.j_invariant() == E65.j_invariant()


# In[104]:


a = E56.j_invariant()
a


# In[105]:


b = E65.j_invariant()
b, b.norm(), a.norm() == b.norm()


# In[106]:


S2 = Mod(b.norm(), (l_A)^n_A)
S2


# In[107]:


S1 = Mod(E34.j_invariant().norm(), (l_B)^n_B)
S1


# In[108]:


R1 = P1 + Integer(S1) * Q1
R1


# In[109]:


Phi1 = isogeny_walk (E, R1, l_B, n_B)
Phi1


# In[110]:


R2 = P0 + Integer(S2) * Q0
R2


# In[111]:


Phi2 = isogeny_walk (E, R2, l_A, n_A)
Phi2


# In[112]:


E2 = Phi2.codomain()
E1 = Phi1.codomain()
E1, E2


# In[113]:


Phi1_P0, Phi1_Q0  = Phi1(P0), Phi1(Q0)
Phi1_P0, Phi1_Q0


# In[114]:


Phi2_P1, Phi2_Q1  = Phi2(P1), Phi2(Q1)
Phi2_P1, Phi2_Q1


# In[115]:


Phi12 = isogeny_walk(E2, Phi2_P1 + Integer(S1) * Phi2_Q1, l_B,n_B)
Phi12


# In[116]:


Phi21 = isogeny_walk(E1, Phi1_P0 + Integer(S2) * Phi1_Q0, l_A,n_A)
Phi21


# In[117]:


E12 = Phi12.codomain()
E12, E12.j_invariant()


# In[118]:


E21 = Phi21.codomain()
E21, E21.j_invariant()


# In[119]:


E21.j_invariant() == E12.j_invariant()


# In[120]:


"""  MLCBT - KEP  with n = 4 """


# In[121]:


"""  We will keep the general parameters and just evolves from l= h-1 """


# In[122]:



Integer(S3).binary(), Integer(S4).binary(), Integer(S5).binary(), Integer(S6).binary()


# In[153]:


hash(Integer(S3)).__xor__(hash(Integer(E34.j_invariant().norm())))


# In[154]:


k3 = Integer(randint(0, l_B^n_B - 1))
k4 = Integer(randint(0, l_B^n_B - 1))
k5 = Integer(randint(0, l_A^n_A - 1))
k6 = Integer(randint(0, l_A^n_A - 1))

k3, k4, k5, k6


# In[143]:


S3.__xor__(E34.j_invariant())


# In[157]:


c3 = hash(k3).__xor__(hash(Integer(E34.j_invariant().norm())))
c4 = hash(k4).__xor__(hash(Integer(E43.j_invariant().norm())))

c3, c4


# In[160]:


c3 = k3.__xor__(Integer(E34.j_invariant().norm()))
c4 = k4.__xor__(Integer(E43.j_invariant().norm()))

c3, c4


# In[169]:


""" The participant P_4 retrieves k3 and computes k3 * k4 """
c3.__xor__(Integer(E43.j_invariant().norm())) == k3
Integer(Mod(c3.__xor__(Integer(E43.j_invariant().norm())) * k4, l_B^n_B))


# In[170]:


""" The participant P_3 retrieves k4 and computes k4 * k3 """
c4.__xor__(Integer(E34.j_invariant().norm())) == k4
Integer(Mod(c4.__xor__(Integer(E34.j_invariant().norm())) * k3, l_B^n_B))


# In[171]:


S1 = Integer(Mod(c4.__xor__(Integer(E34.j_invariant().norm())) * k3, l_B^n_B))
S1


# In[172]:


c5 = k5.__xor__(Integer(E56.j_invariant().norm()))
c6 = k6.__xor__(Integer(E65.j_invariant().norm()))

c5, c6


# In[173]:


""" The participant P_5 retrieves k6 and computes k5 * k6 """

Integer(Mod(c6.__xor__(Integer(E56.j_invariant().norm())) * k5, l_A^n_A))


# In[174]:


""" The participant P_6 retrieves k5 and computes k6 * k5 """

Integer(Mod(c5.__xor__(Integer(E65.j_invariant().norm())) * k6, l_A^n_A))


# In[176]:


S2 = Integer(Mod(c5.__xor__(Integer(E65.j_invariant().norm())) * k6, l_A^n_A))
S2


# In[177]:


R1 = P1 + Integer(S1) * Q1
R1


# In[178]:


R2 = P0 + Integer(S2) * Q0
R2


# In[179]:


Phi1 = isogeny_walk (E, R1, l_B, n_B)
Phi1


# In[180]:


Phi2 = isogeny_walk (E, R2, l_A, n_A)
Phi2


# In[181]:


E2 = Phi2.codomain()
E1 = Phi1.codomain()
E1, E2


# In[182]:


Phi1_P0, Phi1_Q0  = Phi1(P0), Phi1(Q0)
Phi1_P0, Phi1_Q0


# In[183]:


Phi2_P1, Phi2_Q1  = Phi2(P1), Phi2(Q1)
Phi2_P1, Phi2_Q1


# In[184]:


Phi12 = isogeny_walk(E2, Phi2_P1 + Integer(S1) * Phi2_Q1, l_B,n_B)
Phi12


# In[185]:


Phi21 = isogeny_walk(E1, Phi1_P0 + Integer(S2) * Phi1_Q0, l_A,n_A)
Phi21


# In[186]:


E12 = Phi12.codomain(), E21 = Phi21.codomain()
E12, E12.j_invariant(), E21, E21.j_invariant(), E21.j_invariant() == E12.j_invariant()


# In[187]:


E12 = Phi12.codomain()
E12, E12.j_invariant()


# In[188]:


E21 = Phi21.codomain()
E21, E21.j_invariant()


# In[189]:


E21.j_invariant() == E12.j_invariant()


# In[ ]:




