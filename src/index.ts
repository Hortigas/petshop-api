import { PrismaClient } from '@prisma/client';
import bodyParser from 'body-parser';
import express from 'express';

const prisma = new PrismaClient();
const app = express();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get('/pessoas', async (req, res) => {
    const pessoas = await prisma.pessoa.findMany({
        include: {
            telefone: true,
            endereco: {
                include: {
                    cidade: true
                }
            },
            cliente: true,
            funcionario: true
        }
    });
    res.json(pessoas);
});

app.post('/pessoas', async (req, res) => {
    const pessoa = req.body;
    await prisma.pessoa.create({ data: pessoa });
    res.status(201).send('ok');
});

app.put('/pessoas/:id', (req, res) => {
    const id = Number(req.params.id);
    const pessoa = req.body;
    prisma.pessoa.update({
        where: { id },
        data: pessoa
    });
});

app.delete('/pessoas/:id', (req, res) => {
    const id = Number(req.params.id);
    prisma.pessoa.delete({ where: { id } });
});

// app.route('/:estado/cidades')
//     .get(async (req, res) => {
//         const estado = req.params.estado;
//         const rawCidades = await prisma.cidade.findMany({ where: { estado: { nome: estado } } });
//         const cidades = rawCidades.map((city => (city.nome)));
//         res.json(cidades);

//     })
//     .post(async (req, res) => {
//         try {
//             const estadoName = req.params.estado;
//             const estado = await prisma.estado.findUnique({ where: { nome: estadoName } });
//             if (estado === null) throw new Error('estado não encontrado');
//             const { nome } = req.body as { nome: string; };
//             if (!nome || nome.length === 0) throw new Error('formato do corpo da requisição incorreto');
//             await prisma.cidade.create({ data: { nome: nome, estadoId: estado.id } });
//             res.status(200).send('ok');
//         } catch (err: any) {
//             if (err instanceof Prisma.PrismaClientKnownRequestError) {
//                 if (err.code === 'P2002')
//                     res.status(404).send('cidade já existe');
//             }
//             res.status(404).send(err.message);
//         }
//     })
//     .put(async (req, res) => {

//     });

// app.route('/estados')
//     .get(async (req, res) => {
//         const rawEstados = await prisma.estado.findMany();
//         const estados = rawEstados.map((estado) => estado.nome);
//         res.json(estados);
//     })
//     .post(async (req, res) => {
//         try {
//             const estado = req.body.estado;
//             await prisma.estado.create({ data: { nome: estado } });
//             res.status(201).send();
//         } catch (err) {
//             res.status(400).send('Estado já existe');
//         }
//     });
// app.delete('/estados/:id', async (req, res) => {
//     try {
//         const id = Number(req.params.id);
//         await prisma.estado.delete({ where: { id } });
//         res.status(200).send();
//     } catch (err) {
//         res.status(400).send('Estado não existe');
//     }
// });

//  app.post('/post', async (req, res) => {
//      const { title, content, authorEmail } = req.body;
//      const post = await prisma.post.create({
//          data: {
//              title,
//              content,
//              published: false,
//             author: { connect: { email: authorEmail } },
//          },
//      });
//      res.json(post);
//  });

//  app.put('/publish/:id', async (req, res) => {
//      const { id } = req.params;
//      const post = await prisma.post.update({
//          where: { id },
//          data: { published: true },
//      });
//      res.json(post);
//  });

//  app.delete('/user/:id', async (req, res) => {
//      const { id } = req.params;
//      const user = await prisma.user.delete({
//          where: {
// id,
//          },
//     });
//      res.json(user);
//  });

app.listen(3333);