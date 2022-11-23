interface Pessoa {
    id: number;
    nome: string;
    email: string;
    codNac: string;
    telefone: Telefone[];
    endereco: Endereco[];
}

interface Telefone {
    numero: string;
}

interface Endereco {
    id: number;
    logradouro: string;
    numero: string;
    complemento: string;
    bairro: string;
    cep: string;
    cidadeId: string;
}

export interface PessoaRepository {
    getPessoas: () => Promise<Pessoa[]>;
    getPessoa: (id: number) => Promise<Pessoa>;
}