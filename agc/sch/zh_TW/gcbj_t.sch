/* 
================================================================================
檔案代號:gcbj_t
檔案名稱:券核銷審核明細資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table gcbj_t
(
gcbjent       number(5)      ,/* 企業編號 */
gcbjdocno       varchar2(20)      ,/* 繳款單號 */
gcbjseq       number(10,0)      ,/* 項次 */
gcbjseq1       number(10,0)      ,/* 序號 */
gcbj001       varchar2(30)      ,/* 券編號 */
gcbj002       varchar2(10)      ,/* 券種編號 */
gcbj003       varchar2(10)      ,/* 審核前券狀態 */
gcbj004       number(20,6)      ,/* 售券實收金額 */
gcbj005       number(20,6)      ,/* 折扣率 */
gcbj006       varchar2(10)      ,/* 缺單理由 */
gcbj007       varchar2(255)      ,/* 備註 */
gcbj008       varchar2(10)      ,/* 審核狀態 */
gcbj009       varchar2(10)      ,/* 審核營運組織 */
gcbj010       date      ,/* 審核日期 */
gcbj011       varchar2(20)      ,/* 審核人員 */
gcbjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcbjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcbjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcbjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcbjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcbjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcbjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcbjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcbjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcbjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcbjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcbjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcbjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcbjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcbjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcbjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcbjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcbjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcbjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcbjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcbjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcbjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcbjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcbjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcbjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcbjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcbjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcbjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcbjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcbjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcbj_t add constraint gcbj_pk primary key (gcbjent,gcbjdocno,gcbjseq,gcbjseq1) enable validate;

create unique index gcbj_pk on gcbj_t (gcbjent,gcbjdocno,gcbjseq,gcbjseq1);

grant select on gcbj_t to tiptop;
grant update on gcbj_t to tiptop;
grant delete on gcbj_t to tiptop;
grant insert on gcbj_t to tiptop;

exit;
