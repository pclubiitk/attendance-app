const prisma = require("../db/prisma")

const createUser = async (employeeId, name, position, password, role) => {
  try {
    const test = await getUser(employeeId)
    if(test){
      console.log(test)
      return
    } 
    const user = await prisma.user.create({
      data: {
        role,
        profile: {
          create: {
            employeeId,
            name,
            position,
            password,
          },
        },
      },
    });
    console.log("User created:", user);
  } catch (error) {
    console.error("Error creating user:", error);
    return {error}
  }
}

const getUsers = async () => {
  try{
    const users = await prisma.user.findMany({
      include: {
        profile: true,
      }
    });
    return users
  }catch (error){
    console.log(error)
  }
}

const getUser = async (employeeId) => {
  try{
    const user = await prisma.user.findFirst({
      where: {
        profile: {
            employeeId
          }
      },
      include: {
        profile: true
      }
    })
    return user
  }catch(error){
    console.log(error)
  }
}

module.exports = {
  test: "HELLO",
  createUser,
  getUsers,
  getUser
}