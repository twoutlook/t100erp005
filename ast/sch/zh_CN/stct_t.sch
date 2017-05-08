/* 
================================================================================
檔案代號:stct_t
檔案名稱:分銷合約申請相關經銷商設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stct_t
(
stctent       number(5)      ,/* 企業編號 */
stctsite       varchar2(10)      ,/* 營運組織 */
stctunit       varchar2(10)      ,/* 制定組織 */
stctdocno       varchar2(20)      ,/* 單據編號 */
stctseq       number(10,0)      ,/* 項次 */
stct001       varchar2(10)      ,/* 經銷商編號 */
stctud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stctud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stctud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stctud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stctud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stctud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stctud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stctud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stctud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stctud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stctud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stctud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stctud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stctud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stctud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stctud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stctud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stctud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stctud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stctud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stctud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stctud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stctud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stctud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stctud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stctud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stctud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stctud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stctud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stctud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stct_t add constraint stct_pk primary key (stctent,stctdocno,stctseq) enable validate;

create unique index stct_pk on stct_t (stctent,stctdocno,stctseq);

grant select on stct_t to tiptop;
grant update on stct_t to tiptop;
grant delete on stct_t to tiptop;
grant insert on stct_t to tiptop;

exit;
