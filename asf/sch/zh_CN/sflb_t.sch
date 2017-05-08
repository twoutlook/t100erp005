/* 
================================================================================
檔案代號:sflb_t
檔案名稱:工單挪料記錄套數單身檔（目的）
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sflb_t
(
sflbent       number(5)      ,/* 企業編號 */
sflbsite       varchar2(10)      ,/* 營運據點 */
sflbdocno       varchar2(20)      ,/* 挪料序號 */
sflbseq       number(10,0)      ,/* 項次 */
sflb001       varchar2(20)      ,/* 工單單號 */
sflb002       number(20,6)      ,/* 生產數量 */
sflb003       number(20,6)      ,/* 已發套數 */
sflb004       number(20,6)      ,/* 已入庫量 */
sflb005       number(20,6)      ,/* 撥入套數 */
sflbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sflbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sflbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sflbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sflbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sflbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sflbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sflbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sflbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sflbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sflbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sflbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sflbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sflbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sflbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sflbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sflbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sflbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sflbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sflbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sflbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sflbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sflbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sflbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sflbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sflbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sflbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sflbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sflbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sflbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sflb_t add constraint sflb_pk primary key (sflbent,sflbsite,sflbdocno,sflbseq) enable validate;

create unique index sflb_pk on sflb_t (sflbent,sflbsite,sflbdocno,sflbseq);

grant select on sflb_t to tiptop;
grant update on sflb_t to tiptop;
grant delete on sflb_t to tiptop;
grant insert on sflb_t to tiptop;

exit;
