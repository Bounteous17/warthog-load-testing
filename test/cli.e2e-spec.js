const { v2: compose } = require('docker-compose');
const { createClient: createRedisClient } = require('redis');

describe('e2e', () => {
    it('should execute provided function', async () => {
        await compose.buildOne('warthog', { cwd: './example' });
        await compose.upMany(['warthog', 'redis'], { cwd: './example', log: true });

        const clients = {
            redis: createRedisClient()
        };

        await clients.redis.connect();
        await clients.redis.flushAll();

        const getAllKeys = async () => clients.redis.keys('*');

        const initialKeys = await getAllKeys();
        expect(initialKeys).toHaveLength(0);

        await compose.exec('warthog', 'pnpm start', { cwd: './example', log: true });

        const finalKeys = await getAllKeys();
        expect(finalKeys).toHaveLength(32);

        await clients.redis.disconnect();
        await compose.down({ cwd: './example' });
    });
});
