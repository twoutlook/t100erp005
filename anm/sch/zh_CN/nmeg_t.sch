/* 
================================================================================
檔案代號:nmeg_t
檔案名稱:預計資金檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmeg_t
(
nmegent       number(5)      ,/* 企業代碼 */
nmegownid       varchar2(20)      ,/* 資料所有者 */
nmegowndp       varchar2(10)      ,/* 資料所屬部門 */
nmegcrtid       varchar2(20)      ,/* 資料建立者 */
nmegcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmegcrtdt       timestamp(0)      ,/* 資料創建日 */
nmegmodid       varchar2(20)      ,/* 資料修改者 */
nmegmoddt       timestamp(0)      ,/* 最近修改日 */
nmegstus       varchar2(10)      ,/* 狀態碼 */
nmegsite       varchar2(10)      ,/* 營運據點 */
nmegdocdt       date      ,/* 單據日期 */
nmegseq       number(10,0)      ,/* 項次 */
nmeg001       varchar2(20)      ,/* 資金模擬方案編號 */
nmeg002       varchar2(10)      ,/* 收支項目 */
nmeg003       date      ,/* 起始日期 */
nmeg004       date      ,/* 截止日期 */
nmeg005       varchar2(10)      ,/* 模擬幣別 */
nmeg006       varchar2(10)      ,/* 收支項目版本號 */
nmeg007       varchar2(10)      ,/* 來源組織 */
nmeg008       varchar2(10)      ,/* 交易幣別 */
nmeg009       number(20,6)      ,/* 交易金額 */
nmeg010       number(20,10)      ,/* 來源組織匯率 */
nmeg011       number(20,6)      ,/* 來源組織金額 */
nmeg012       number(20,10)      ,/* 模擬匯率 */
nmeg013       number(20,6)      ,/* 模擬金額 */
nmeg014       varchar2(80)      ,/* 備註 */
nmeg015       varchar2(10)      ,/* 交易對象 */
nmeg016       varchar2(10)      ,/* 交易銀行 */
nmeg017       varchar2(1)      ,/* 來源 */
nmegud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmegud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmegud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmegud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmegud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmegud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmegud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmegud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmegud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmegud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmegud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmegud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmegud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmegud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmegud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmegud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmegud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmegud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmegud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmegud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmegud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmegud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmegud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmegud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmegud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmegud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmegud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmegud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmegud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmegud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmeg_t add constraint nmeg_pk primary key (nmegent,nmegseq,nmeg001) enable validate;

create unique index nmeg_pk on nmeg_t (nmegent,nmegseq,nmeg001);

grant select on nmeg_t to tiptop;
grant update on nmeg_t to tiptop;
grant delete on nmeg_t to tiptop;
grant insert on nmeg_t to tiptop;

exit;
