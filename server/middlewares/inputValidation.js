

exports.keyImageValidator = (req,res,next)=>{
    console.log("key image validator got hit");

    // verify that the image captured only exactly one person
    
    next();
}