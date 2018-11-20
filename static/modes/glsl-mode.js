// Copyright (c) 2018, Compiler Explorer Authors
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//     * Redistributions of source code must retain the above copyright notice,
//       this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
'use strict';
var $ = require('jquery');
var cpp = require('vs/basic-languages/src/cpp');
var cppp = require('./cppp-mode');

// We need to create a new definition for cpp so we can remove invalid keywords

function definition() {
    var glsl = $.extend(true, {}, cppp); // deep copy

    function addKeywords(keywords) {
        // (Ruben) Done one by one as if you just push them all, Monaco complains that they're not strings, but as
        // far as I can tell, they indeed are all strings. This somehow fixes it. If you know how to fix it, plz go
        for (var i = 0; i < keywords.length; ++i) {
            glsl.keywords.push(keywords[i]);
        }
    }

    glsl.tokenPostfix = '.cu';

    // Keywords for GLSL
    addKeywords(["uniform", "buffer", "sampler"]);

    return glsl;
}

monaco.languages.register({id: 'glsl'});
monaco.languages.setLanguageConfiguration('glsl', cpp.conf);
monaco.languages.setMonarchTokensProvider('glsl', definition());
