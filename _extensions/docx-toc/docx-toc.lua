-- Using identifier instead of classes as there should only be one instance
--[[
::: {#toc}
:::
-- ]]
local toc_title = "Table of Contents"
local toc_level = "3"

function Meta(meta)
  if meta.docxtoc then
    if meta.docxtoc.title then
      toc_title = pandoc.utils.stringify(meta.docxtoc.title)
    end
    if meta.docxtoc.level then
      toc_level = pandoc.utils.stringify(meta.docxtoc.level)
    end
  end
end

function Div(div)
  if div.identifier == 'docxtoc' then
    local toc_xml = [[
<w:sdt>
  <w:sdtPr>
    <w:docPartObj>
      <w:docPartGallery w:val="Table of Contents" />
      <w:docPartUnique />
    </w:docPartObj>
  </w:sdtPr>
  <w:sdtContent>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="TOCHeading" />
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve">]] .. toc_title .. [[</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:fldChar w:fldCharType="begin" w:dirty="true" />
        <w:instrText xml:space="preserve">TOC \o "1-]] .. toc_level .. [[" \h \z \u</w:instrText>
        <w:fldChar w:fldCharType="separate" />
        <w:fldChar w:fldCharType="end" />
      </w:r>
    </w:p>
  </w:sdtContent>
</w:sdt>
    ]]
    return { pandoc.Div(pandoc.RawBlock('openxml', toc_xml)) }
  end
end

return {
  { Meta = Meta },
  { Div = Div }
}
