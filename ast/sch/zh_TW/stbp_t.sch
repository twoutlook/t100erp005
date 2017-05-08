/* 
================================================================================
檔案代號:stbp_t
檔案名稱:費用單銷售明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbp_t
(
stbpent       number(5)      ,/* 企業代碼 */
stbpsite       varchar2(10)      ,/* 營運據點 */
stbpdocno       varchar2(20)      ,/* 單據編號 */
stbpseq       number(10,0)      ,/* 項次 */
stbp001       number(10,0)      ,/* 明細項次 */
stbp002       varchar2(10)      ,/* 費用編號 */
stbp003       varchar2(500)      ,/* 費用名稱 */
stbp004       varchar2(1)      ,/* 資料類型 */
stbp005       date      ,/* 開始日期 */
stbp006       date      ,/* 結束日期 */
stbp007       number(20,6)      ,/* 營業額 */
stbp008       number(20,6)      ,/* 費用扣率 */
stbp009       number(20,6)      ,/* 費用金額 */
stbpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stbpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stbpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stbpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stbpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stbpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stbpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stbpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stbpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stbpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stbpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stbpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stbpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stbpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stbpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stbpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stbpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stbpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stbpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stbpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stbpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stbpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stbpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stbpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stbpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stbpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stbpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stbpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stbpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stbpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stbp_t add constraint stbp_pk primary key (stbpent,stbpdocno,stbpseq) enable validate;

create unique index stbp_pk on stbp_t (stbpent,stbpdocno,stbpseq);

grant select on stbp_t to tiptop;
grant update on stbp_t to tiptop;
grant delete on stbp_t to tiptop;
grant insert on stbp_t to tiptop;

exit;
