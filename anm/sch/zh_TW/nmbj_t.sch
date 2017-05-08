/* 
================================================================================
檔案代號:nmbj_t
檔案名稱:資金計劃明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table nmbj_t
(
nmbjent       number(5)      ,/* 企業編號 */
nmbjdocno       varchar2(20)      ,/* 資金計劃單號 */
nmbjseq       number(10,0)      ,/* 序號 */
nmbj001       varchar2(10)      ,/* 組織 */
nmbj002       varchar2(10)      ,/* 收支項目 */
nmbj003       date      ,/* 編製起始日 */
nmbj004       date      ,/* 編製結束日 */
nmbj005       varchar2(10)      ,/* 幣別 */
nmbj006       number(20,6)      ,/* 初編金額 */
nmbj007       number(20,6)      ,/* 變更後金額 */
nmbj008       number(20,6)      ,/* 審批金額 */
nmbj009       number(20,6)      ,/* 最後異動金額 */
nmbjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmbj_t add constraint nmbj_pk primary key (nmbjent,nmbjdocno,nmbjseq) enable validate;

create unique index nmbj_pk on nmbj_t (nmbjent,nmbjdocno,nmbjseq);

grant select on nmbj_t to tiptop;
grant update on nmbj_t to tiptop;
grant delete on nmbj_t to tiptop;
grant insert on nmbj_t to tiptop;

exit;
