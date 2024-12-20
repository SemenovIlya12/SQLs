PGDMP  1    "            	    |            N2_NEW    17.0    17.0 ;    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    24576    N2_NEW    DATABASE     |   CREATE DATABASE "N2_NEW" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "N2_NEW";
                     postgres    false            �            1259    24835    Marks    TABLE     �   CREATE TABLE public."Marks" (
    student_id integer NOT NULL,
    subject character varying(100) NOT NULL,
    score bigint NOT NULL,
    "Teacher" character varying(100) NOT NULL
);
    DROP TABLE public."Marks";
       public         heap r       postgres    false            �            1259    24834    Marks_student_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Marks_student_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."Marks_student_id_seq";
       public               postgres    false    226                        0    0    Marks_student_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."Marks_student_id_seq" OWNED BY public."Marks".student_id;
          public               postgres    false    225            �            1259    24818    Students    TABLE     �   CREATE TABLE public."Students" (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    subject_1 character varying(75) NOT NULL,
    subject_2 character varying(75) NOT NULL,
    subject_3 character varying(75) NOT NULL
);
    DROP TABLE public."Students";
       public         heap r       postgres    false            �            1259    24817    Students_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Students_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Students_id_seq";
       public               postgres    false    222                       0    0    Students_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."Students_id_seq" OWNED BY public."Students".id;
          public               postgres    false    221            �            1259    24809    Subjects    TABLE     e   CREATE TABLE public."Subjects" (
    id integer NOT NULL,
    name character varying(75) NOT NULL
);
    DROP TABLE public."Subjects";
       public         heap r       postgres    false            �            1259    24808    Subjects_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Subjects_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Subjects_id_seq";
       public               postgres    false    220                       0    0    Subjects_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."Subjects_id_seq" OWNED BY public."Subjects".id;
          public               postgres    false    219            �            1259    24825    Teachers    TABLE     �   CREATE TABLE public."Teachers" (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    subject character varying(100) DEFAULT '0'::character varying NOT NULL
);
    DROP TABLE public."Teachers";
       public         heap r       postgres    false            �            1259    24824    Teachers_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Teachers_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Teachers_id_seq";
       public               postgres    false    224                       0    0    Teachers_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."Teachers_id_seq" OWNED BY public."Teachers".id;
          public               postgres    false    223            �            1259    24842    examinations    TABLE     �   CREATE TABLE public.examinations (
    id integer NOT NULL,
    subject character varying(100) NOT NULL,
    teacher character varying(100) NOT NULL,
    "group" bigint NOT NULL,
    status character varying(75),
    date date
);
     DROP TABLE public.examinations;
       public         heap r       postgres    false            �            1259    24841    examinations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.examinations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.examinations_id_seq;
       public               postgres    false    228                       0    0    examinations_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.examinations_id_seq OWNED BY public.examinations.id;
          public               postgres    false    227            �            1259    24800    groups    TABLE     m   CREATE TABLE public.groups (
    group_id integer NOT NULL,
    group_name character varying(50) NOT NULL
);
    DROP TABLE public.groups;
       public         heap r       postgres    false            �            1259    24799    groups_group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.groups_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.groups_group_id_seq;
       public               postgres    false    218                       0    0    groups_group_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.groups_group_id_seq OWNED BY public.groups.group_id;
          public               postgres    false    217            ?           2604    24838    Marks student_id    DEFAULT     x   ALTER TABLE ONLY public."Marks" ALTER COLUMN student_id SET DEFAULT nextval('public."Marks_student_id_seq"'::regclass);
 A   ALTER TABLE public."Marks" ALTER COLUMN student_id DROP DEFAULT;
       public               postgres    false    226    225    226            <           2604    24821    Students id    DEFAULT     n   ALTER TABLE ONLY public."Students" ALTER COLUMN id SET DEFAULT nextval('public."Students_id_seq"'::regclass);
 <   ALTER TABLE public."Students" ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221    222            ;           2604    24812    Subjects id    DEFAULT     n   ALTER TABLE ONLY public."Subjects" ALTER COLUMN id SET DEFAULT nextval('public."Subjects_id_seq"'::regclass);
 <   ALTER TABLE public."Subjects" ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219    220            =           2604    24828    Teachers id    DEFAULT     n   ALTER TABLE ONLY public."Teachers" ALTER COLUMN id SET DEFAULT nextval('public."Teachers_id_seq"'::regclass);
 <   ALTER TABLE public."Teachers" ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    223    224            @           2604    24845    examinations id    DEFAULT     r   ALTER TABLE ONLY public.examinations ALTER COLUMN id SET DEFAULT nextval('public.examinations_id_seq'::regclass);
 >   ALTER TABLE public.examinations ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    228    227    228            :           2604    24803    groups group_id    DEFAULT     r   ALTER TABLE ONLY public.groups ALTER COLUMN group_id SET DEFAULT nextval('public.groups_group_id_seq'::regclass);
 >   ALTER TABLE public.groups ALTER COLUMN group_id DROP DEFAULT;
       public               postgres    false    218    217    218            �          0    24835    Marks 
   TABLE DATA           H   COPY public."Marks" (student_id, subject, score, "Teacher") FROM stdin;
    public               postgres    false    226   yD       �          0    24818    Students 
   TABLE DATA           O   COPY public."Students" (id, name, subject_1, subject_2, subject_3) FROM stdin;
    public               postgres    false    222   �D       �          0    24809    Subjects 
   TABLE DATA           .   COPY public."Subjects" (id, name) FROM stdin;
    public               postgres    false    220    E       �          0    24825    Teachers 
   TABLE DATA           7   COPY public."Teachers" (id, name, subject) FROM stdin;
    public               postgres    false    224   �E       �          0    24842    examinations 
   TABLE DATA           S   COPY public.examinations (id, subject, teacher, "group", status, date) FROM stdin;
    public               postgres    false    228   �E       �          0    24800    groups 
   TABLE DATA           6   COPY public.groups (group_id, group_name) FROM stdin;
    public               postgres    false    218   F                  0    0    Marks_student_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Marks_student_id_seq"', 1, false);
          public               postgres    false    225                       0    0    Students_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Students_id_seq"', 6, true);
          public               postgres    false    221                       0    0    Subjects_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Subjects_id_seq"', 11, true);
          public               postgres    false    219            	           0    0    Teachers_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Teachers_id_seq"', 4, true);
          public               postgres    false    223            
           0    0    examinations_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.examinations_id_seq', 1, false);
          public               postgres    false    227                       0    0    groups_group_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.groups_group_id_seq', 2, true);
          public               postgres    false    217            P           2606    24840    Marks Marks_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Marks"
    ADD CONSTRAINT "Marks_pkey" PRIMARY KEY (student_id);
 >   ALTER TABLE ONLY public."Marks" DROP CONSTRAINT "Marks_pkey";
       public                 postgres    false    226            J           2606    24823    Students Students_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "Students_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."Students" DROP CONSTRAINT "Students_pkey";
       public                 postgres    false    222            F           2606    24816    Subjects Subjects_id_key 
   CONSTRAINT     U   ALTER TABLE ONLY public."Subjects"
    ADD CONSTRAINT "Subjects_id_key" UNIQUE (id);
 F   ALTER TABLE ONLY public."Subjects" DROP CONSTRAINT "Subjects_id_key";
       public                 postgres    false    220            H           2606    24814    Subjects Subjects_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Subjects"
    ADD CONSTRAINT "Subjects_pkey" PRIMARY KEY (name);
 D   ALTER TABLE ONLY public."Subjects" DROP CONSTRAINT "Subjects_pkey";
       public                 postgres    false    220            L           2606    24833    Teachers Teachers_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public."Teachers"
    ADD CONSTRAINT "Teachers_name_key" UNIQUE (name);
 H   ALTER TABLE ONLY public."Teachers" DROP CONSTRAINT "Teachers_name_key";
       public                 postgres    false    224            N           2606    24831    Teachers Teachers_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Teachers"
    ADD CONSTRAINT "Teachers_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."Teachers" DROP CONSTRAINT "Teachers_pkey";
       public                 postgres    false    224            R           2606    24847    examinations examinations_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.examinations
    ADD CONSTRAINT examinations_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.examinations DROP CONSTRAINT examinations_pkey;
       public                 postgres    false    228            B           2606    24807    groups groups_group_name_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_group_name_key UNIQUE (group_name);
 F   ALTER TABLE ONLY public.groups DROP CONSTRAINT groups_group_name_key;
       public                 postgres    false    218            D           2606    24805    groups groups_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (group_id);
 <   ALTER TABLE ONLY public.groups DROP CONSTRAINT groups_pkey;
       public                 postgres    false    218            W           2606    24868    Marks Marks_fk0    FK CONSTRAINT     z   ALTER TABLE ONLY public."Marks"
    ADD CONSTRAINT "Marks_fk0" FOREIGN KEY (student_id) REFERENCES public."Students"(id);
 =   ALTER TABLE ONLY public."Marks" DROP CONSTRAINT "Marks_fk0";
       public               postgres    false    226    222    4682            X           2606    24873    Marks Marks_fk1    FK CONSTRAINT     y   ALTER TABLE ONLY public."Marks"
    ADD CONSTRAINT "Marks_fk1" FOREIGN KEY (subject) REFERENCES public."Subjects"(name);
 =   ALTER TABLE ONLY public."Marks" DROP CONSTRAINT "Marks_fk1";
       public               postgres    false    220    226    4680            Y           2606    24878    Marks Marks_fk3    FK CONSTRAINT     {   ALTER TABLE ONLY public."Marks"
    ADD CONSTRAINT "Marks_fk3" FOREIGN KEY ("Teacher") REFERENCES public."Teachers"(name);
 =   ALTER TABLE ONLY public."Marks" DROP CONSTRAINT "Marks_fk3";
       public               postgres    false    226    224    4684            S           2606    24848    Students Students_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "Students_fk2" FOREIGN KEY (subject_1) REFERENCES public."Subjects"(name);
 C   ALTER TABLE ONLY public."Students" DROP CONSTRAINT "Students_fk2";
       public               postgres    false    4680    220    222            T           2606    24853    Students Students_fk3    FK CONSTRAINT     �   ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "Students_fk3" FOREIGN KEY (subject_2) REFERENCES public."Subjects"(name);
 C   ALTER TABLE ONLY public."Students" DROP CONSTRAINT "Students_fk3";
       public               postgres    false    220    4680    222            U           2606    24858    Students Students_fk4    FK CONSTRAINT     �   ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "Students_fk4" FOREIGN KEY (subject_3) REFERENCES public."Subjects"(name);
 C   ALTER TABLE ONLY public."Students" DROP CONSTRAINT "Students_fk4";
       public               postgres    false    222    220    4680            V           2606    24863    Teachers Teachers_fk2    FK CONSTRAINT        ALTER TABLE ONLY public."Teachers"
    ADD CONSTRAINT "Teachers_fk2" FOREIGN KEY (subject) REFERENCES public."Subjects"(name);
 C   ALTER TABLE ONLY public."Teachers" DROP CONSTRAINT "Teachers_fk2";
       public               postgres    false    4680    224    220            Z           2606    24883    examinations examinations_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.examinations
    ADD CONSTRAINT examinations_fk1 FOREIGN KEY (subject) REFERENCES public."Subjects"(name);
 G   ALTER TABLE ONLY public.examinations DROP CONSTRAINT examinations_fk1;
       public               postgres    false    4680    220    228            [           2606    24888    examinations examinations_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.examinations
    ADD CONSTRAINT examinations_fk2 FOREIGN KEY (teacher) REFERENCES public."Teachers"(name);
 G   ALTER TABLE ONLY public.examinations DROP CONSTRAINT examinations_fk2;
       public               postgres    false    224    228    4684            \           2606    24893    examinations examinations_fk3    FK CONSTRAINT     �   ALTER TABLE ONLY public.examinations
    ADD CONSTRAINT examinations_fk3 FOREIGN KEY ("group") REFERENCES public.groups(group_id);
 G   ALTER TABLE ONLY public.examinations DROP CONSTRAINT examinations_fk3;
       public               postgres    false    228    4676    218            �      x������ � �      �   z   x�3�K̫L��M,��tM���ϭ�t�H��,.)��2�H-���t��-(-I-RN�L�KNŢԘ�%1�3 ��83���	gXjО�����Լ�R��\��N���!�1�����=... �#G      �   U   x�3��M,��2�t��-(-I-RN�L�KN��t�H��,.)���tM���ϭ�24�Ȩ,�L.�24��KLO�M�+����� Ȓ�      �   T   x�3����ͭ�tM���ϭ�2�t.-ʩ��M,��2�t��K�t��-(-I-RN�L�KN�2�O�
p:g��f�Ur��qqq ��*      �      x������ � �      �      x�3��q�2�pq������ 'A�     