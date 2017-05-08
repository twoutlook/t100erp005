/* 
================================================================================
檔案代號:stij_t
檔案名稱:招商租賃合約申請場地資訊單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stij_t
(
stijent       number(5)      ,/* 企業編號 */
stijsite       varchar2(10)      ,/* 營運組織 */
stijunit       varchar2(10)      ,/* 制定組織 */
stijdocno       varchar2(20)      ,/* 單據編號 */
stijseq       number(10,0)      ,/* 項次 */
stijacti       varchar2(1)      ,/* 有效否 */
stij001       varchar2(20)      ,/* 合約編號 */
stij002       varchar2(20)      ,/* 場地編號 */
stij003       number(20,6)      ,/* 建築面積 */
stij004       number(20,6)      ,/* 測量面積 */
stij005       number(20,6)      ,/* 經營面積 */
stij006       varchar2(10)      ,/* 樓棟編號 */
stij007       varchar2(10)      ,/* 樓層編號 */
stij008       varchar2(10)      ,/* 區域編號 */
stij009       varchar2(10)      ,/* 合約版本 */
stijud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stijud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stijud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stijud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stijud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stijud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stijud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stijud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stijud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stijud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stijud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stijud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stijud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stijud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stijud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stijud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stijud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stijud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stijud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stijud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stijud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stijud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stijud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stijud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stijud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stijud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stijud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stijud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stijud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stijud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stij_t add constraint stij_pk primary key (stijent,stijdocno,stijseq) enable validate;

create unique index stij_pk on stij_t (stijent,stijdocno,stijseq);

grant select on stij_t to tiptop;
grant update on stij_t to tiptop;
grant delete on stij_t to tiptop;
grant insert on stij_t to tiptop;

exit;
