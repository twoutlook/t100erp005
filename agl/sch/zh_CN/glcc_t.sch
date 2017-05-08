/* 
================================================================================
檔案代號:glcc_t
檔案名稱:產品科目依帳套設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glcc_t
(
glccent       number(5)      ,/* 企業編號 */
glccownid       varchar2(20)      ,/* 資料所屬者 */
glccowndp       varchar2(10)      ,/* 資料所有部門 */
glcccrtid       varchar2(20)      ,/* 資料建立者 */
glcccrtdp       varchar2(10)      ,/* 資料建立部門 */
glcccrtdt       timestamp(0)      ,/* 資料創建日 */
glccmodid       varchar2(20)      ,/* 資料修改者 */
glccmoddt       timestamp(0)      ,/* 最近修改日 */
glccld       varchar2(5)      ,/* 帳套 */
glcc001       varchar2(10)      ,/* 設定類型 */
glccseq       number(10,0)      ,/* 項次 */
glcc002       varchar2(24)      ,/* 存貨科目編號 */
glcc003       varchar2(24)      ,/* 進貨(收入)科目編號 */
glcc004       varchar2(24)      ,/* 在製(銷貨成本)科目 */
glcc005       varchar2(24)      ,/* 委外加工費科目 */
glcc006       varchar2(24)      ,/* 會計科目編號(預留２) */
glcc007       varchar2(1)      ,/* 科目彙總方式 */
glcc008       varchar2(100)      ,/* 其他設定值 */
glcc011       varchar2(10)      ,/* 成本分群 */
glcc012       varchar2(10)      ,/* 採購(銷售)分群 */
glcc013       varchar2(10)      ,/* 交易通路 */
glcc014       varchar2(10)      ,/* 營運據點 */
glcc015       varchar2(10)      ,/* 倉庫別 */
glcc016       varchar2(40)      ,/* 料件編號 */
glccstus       varchar2(10)      ,/* 狀態碼 */
glcc017       varchar2(24)      ,/* 科目六(制費三） */
glcc018       varchar2(24)      ,/* 科目七(制費四） */
glcc019       varchar2(24)      ,/* 科目八(制費五） */
glccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glcc_t add constraint glcc_pk primary key (glccent,glccld,glcc001,glccseq) enable validate;

create unique index glcc_pk on glcc_t (glccent,glccld,glcc001,glccseq);

grant select on glcc_t to tiptop;
grant update on glcc_t to tiptop;
grant delete on glcc_t to tiptop;
grant insert on glcc_t to tiptop;

exit;
