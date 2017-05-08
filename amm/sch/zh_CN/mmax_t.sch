/* 
================================================================================
檔案代號:mmax_t
檔案名稱:會員卡發行單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmax_t
(
mmaxent       number(5)      ,/* 企業編號 */
mmaxsite       varchar2(10)      ,/* 營運據點 */
mmaxunit       varchar2(10)      ,/* 應用組織 */
mmaxdocno       varchar2(20)      ,/* 單據編號 */
mmaxseq       number(10,0)      ,/* 項次 */
mmax001       varchar2(10)      ,/* 卡種編號 */
mmax002       number(5,0)      ,/* 卡號總碼長 */
mmax003       number(5,0)      ,/* 卡號固定代碼長度 */
mmax004       varchar2(30)      ,/* 卡號固定代碼 */
mmax005       number(5,0)      ,/* 卡號流水碼長度 */
mmax006       number(10,0)      ,/* 發行張數 */
mmax007       varchar2(30)      ,/* 開始卡號 */
mmax008       varchar2(30)      ,/* 結束卡號 */
mmax009       varchar2(10)      ,/* 空白卡庫區 */
mmax010       varchar2(10)      ,/* 發行卡庫區 */
mmaxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmaxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmaxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmaxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmaxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmaxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmaxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmaxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmaxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmaxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmaxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmaxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmaxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmaxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmaxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmaxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmaxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmaxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmaxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmaxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmaxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmaxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmaxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmaxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmaxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmaxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmaxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmaxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmaxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmaxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmax_t add constraint mmax_pk primary key (mmaxent,mmaxdocno,mmaxseq) enable validate;

create unique index mmax_pk on mmax_t (mmaxent,mmaxdocno,mmaxseq);

grant select on mmax_t to tiptop;
grant update on mmax_t to tiptop;
grant delete on mmax_t to tiptop;
grant insert on mmax_t to tiptop;

exit;
