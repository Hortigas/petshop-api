/*
  Warnings:

  - Added the required column `clienteId` to the `Servico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dataEntrada` to the `Servico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dataSaida` to the `Servico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `descricao` to the `Servico` table without a default value. This is not possible if the table is not empty.
  - Added the required column `funcionarioId` to the `Servico` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Servico" ADD COLUMN     "clienteId" INTEGER NOT NULL,
ADD COLUMN     "dataEntrada" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "dataSaida" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "descricao" TEXT NOT NULL,
ADD COLUMN     "funcionarioId" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "Cliente" (
    "id" SERIAL NOT NULL,
    "tipo" TEXT NOT NULL,
    "pessoaId" INTEGER NOT NULL,

    CONSTRAINT "Cliente_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Funcionario" (
    "id" SERIAL NOT NULL,
    "funcao" TEXT NOT NULL,
    "pessoaId" INTEGER NOT NULL,

    CONSTRAINT "Funcionario_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Cliente_pessoaId_key" ON "Cliente"("pessoaId");

-- CreateIndex
CREATE UNIQUE INDEX "Funcionario_pessoaId_key" ON "Funcionario"("pessoaId");

-- AddForeignKey
ALTER TABLE "Cliente" ADD CONSTRAINT "Cliente_pessoaId_fkey" FOREIGN KEY ("pessoaId") REFERENCES "Pessoa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Funcionario" ADD CONSTRAINT "Funcionario_pessoaId_fkey" FOREIGN KEY ("pessoaId") REFERENCES "Pessoa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Servico" ADD CONSTRAINT "Servico_funcionarioId_fkey" FOREIGN KEY ("funcionarioId") REFERENCES "Funcionario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Servico" ADD CONSTRAINT "Servico_clienteId_fkey" FOREIGN KEY ("clienteId") REFERENCES "Cliente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
