export interface CidadesRepository {
    create(cidade: string): Promise<void>;
    delete(id: number): Promise<void>;
}