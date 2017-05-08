/* 
================================================================================
檔案代號:stik_t
檔案名稱:招商租賃合約申請品类品牌單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stik_t
(
stikent       number(5)      ,/* 企業編號 */
stiksite       varchar2(10)      ,/* 營運組織 */
stikunit       varchar2(10)      ,/* 制定組織 */
stikdocno       varchar2(20)      ,/* 單據編號 */
stikseq       number(10,0)      ,/* 項次 */
stikacti       varchar2(1)      ,/* 有效否 */
stik001       varchar2(20)      ,/* 合約編號 */
stik002       varchar2(10)      ,/* 品類編號 */
stik003       varchar2(10)      ,/* 品牌編號 */
stikud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stikud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stikud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stikud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stikud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stikud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stikud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stikud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stikud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stikud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stikud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stikud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stikud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stikud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stikud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stikud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stikud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stikud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stikud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stikud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stikud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stikud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stikud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stikud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stikud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stikud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stikud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stikud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stikud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stikud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stik004       varchar2(1)      ,/* 主品類 */
stik005       varchar2(1)      /* 主品牌 */
);
alter table stik_t add constraint stik_pk primary key (stikent,stikdocno,stikseq) enable validate;

create unique index stik_pk on stik_t (stikent,stikdocno,stikseq);

grant select on stik_t to tiptop;
grant update on stik_t to tiptop;
grant delete on stik_t to tiptop;
grant insert on stik_t to tiptop;

exit;
