import { PrismaClient } from '@prisma/client';
import bodyParser from 'body-parser';
import express from 'express';

const prisma = new PrismaClient();
const app = express();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.route('/:estado/cidade')
    .get(async (req, res) => {
        const estado = req.params.estado;
        const cidades = await prisma.cidade.findMany({ where: { estado: { nome: estado } } });
        res.json(cidades);
    })
    .post(async (req, res) => {
        try {
            const estadoName = req.params.estado;
            const estado = await prisma.estado.findUnique({ where: { nome: estadoName } });
            if (!estado) throw new Error('estado não encontrado');
            const { nome } = req.body as { nome: string; };
            await prisma.cidade.create({ data: { nome: nome, estadoId: estado.id } });
            res.json({ status: 'ok' });
        } catch (err: any) {
            res.json({ error: err.message });
        }
    })
    .put(async (req, res) => {

    });

// app.post('/post', async (req, res) => {
//     const { title, content, authorEmail } = req.body;
//     const post = await prisma.post.create({
//         data: {
//             title,
//             content,
//             published: false,
//             author: { connect: { email: authorEmail } },
//         },
//     });
//     res.json(post);
// });

// app.put('/publish/:id', async (req, res) => {
//     const { id } = req.params;
//     const post = await prisma.post.update({
//         where: { id },
//         data: { published: true },
//     });
//     res.json(post);
// });

// app.delete('/user/:id', async (req, res) => {
//     const { id } = req.params;
//     const user = await prisma.user.delete({
//         where: {
//             id,
//         },
//     });
//     res.json(user);
// });

app.listen(3333);