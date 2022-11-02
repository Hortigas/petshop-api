/*
  Warnings:

  - The primary key for the `Cliente` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Cliente` table. All the data in the column will be lost.
  - The primary key for the `Funcionario` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Funcionario` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[pagamentoId]` on the table `Servico` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `pagamentoId` to the `Servico` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "SituacaoPagamento" AS ENUM ('pago', 'pendente');

-- DropForeignKey
ALTER TABLE "Servico" DROP CONSTRAINT "Servico_clienteId_fkey";

-- DropForeignKey
ALTER TABLE "Servico" DROP CONSTRAINT "Servico_funcionarioId_fkey";

-- AlterTable
ALTER TABLE "Cliente" DROP CONSTRAINT "Cliente_pkey",
DROP COLUMN "id";

-- AlterTable
ALTER TABLE "Funcionario" DROP CONSTRAINT "Funcionario_pkey",
DROP COLUMN "id";

-- AlterTable
ALTER TABLE "Servico" ADD COLUMN     "pagamentoId" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "Pagamento" (
    "id" SERIAL NOT NULL,
    "situacao" "SituacaoPagamento" NOT NULL,

    CONSTRAINT "Pagamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PagDinheiro" (
    "dataVencimento" TIMESTAMP(3) NOT NULL,
    "dataPagamento" TIMESTAMP(3) NOT NULL,
    "pagamentoId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "PagCartao" (
    "parcelas" INTEGER NOT NULL,
    "pagamentoId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_PetToServico" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_ProdutoToServico" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "PagDinheiro_pagamentoId_key" ON "PagDinheiro"("pagamentoId");

-- CreateIndex
CREATE UNIQUE INDEX "PagCartao_pagamentoId_key" ON "PagCartao"("pagamentoId");

-- CreateIndex
CREATE UNIQUE INDEX "_PetToServico_AB_unique" ON "_PetToServico"("A", "B");

-- CreateIndex
CREATE INDEX "_PetToServico_B_index" ON "_PetToServico"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ProdutoToServico_AB_unique" ON "_ProdutoToServico"("A", "B");

-- CreateIndex
CREATE INDEX "_ProdutoToServico_B_index" ON "_ProdutoToServico"("B");

-- CreateIndex
CREATE UNIQUE INDEX "Servico_pagamentoId_key" ON "Servico"("pagamentoId");

-- AddForeignKey
ALTER TABLE "PagDinheiro" ADD CONSTRAINT "PagDinheiro_pagamentoId_fkey" FOREIGN KEY ("pagamentoId") REFERENCES "Pagamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PagCartao" ADD CONSTRAINT "PagCartao_pagamentoId_fkey" FOREIGN KEY ("pagamentoId") REFERENCES "Pagamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Servico" ADD CONSTRAINT "Servico_funcionarioId_fkey" FOREIGN KEY ("funcionarioId") REFERENCES "Funcionario"("pessoaId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Servico" ADD CONSTRAINT "Servico_clienteId_fkey" FOREIGN KEY ("clienteId") REFERENCES "Cliente"("pessoaId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Servico" ADD CONSTRAINT "Servico_pagamentoId_fkey" FOREIGN KEY ("pagamentoId") REFERENCES "Pagamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PetToServico" ADD CONSTRAINT "_PetToServico_A_fkey" FOREIGN KEY ("A") REFERENCES "Pet"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PetToServico" ADD CONSTRAINT "_PetToServico_B_fkey" FOREIGN KEY ("B") REFERENCES "Servico"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProdutoToServico" ADD CONSTRAINT "_ProdutoToServico_A_fkey" FOREIGN KEY ("A") REFERENCES "Produto"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProdutoToServico" ADD CONSTRAINT "_ProdutoToServico_B_fkey" FOREIGN KEY ("B") REFERENCES "Servico"("id") ON DELETE CASCADE ON UPDATE CASCADE;
