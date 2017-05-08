/* 
================================================================================
檔案代號:mmdj_t
檔案名稱:高端規則對應日期範圍申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmdj_t
(
mmdjent       number(5)      ,/* 企業編號 */
mmdjacti       varchar2(1)      ,/* 資料有效 */
mmdjsite       varchar2(10)      ,/* 營運組織 */
mmdjunit       varchar2(10)      ,/* 應用組織 */
mmdjdocno       varchar2(20)      ,/* 單據編號 */
mmdj001       varchar2(20)      ,/* 活動規則編號 */
mmdj002       varchar2(10)      ,/* 規則對象編號 */
mmdj003       varchar2(10)      ,/* 進階規則類型 */
mmdj004       varchar2(10)      ,/* 高端規則編號 */
mmdj005       number(10,0)      ,/* 項次 */
mmdj006       date      ,/* 開始日期 */
mmdj007       date      ,/* 結束日期 */
mmdj008       varchar2(8)      ,/* 每日開始時間 */
mmdj009       varchar2(8)      ,/* 每日結束時間 */
mmdj010       varchar2(10)      ,/* 固定日期 */
mmdj011       varchar2(10)      ,/* 固定星期 */
mmdjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmdjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmdjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmdjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmdjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmdjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmdjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmdjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmdjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmdjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmdjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmdjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmdjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmdjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmdjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmdjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmdjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmdjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmdjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmdjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmdjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmdjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmdjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmdjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmdjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmdjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmdjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmdjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmdjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmdjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmdj_t add constraint mmdj_pk primary key (mmdjent,mmdjdocno,mmdj003,mmdj004,mmdj005) enable validate;

create unique index mmdj_pk on mmdj_t (mmdjent,mmdjdocno,mmdj003,mmdj004,mmdj005);

grant select on mmdj_t to tiptop;
grant update on mmdj_t to tiptop;
grant delete on mmdj_t to tiptop;
grant insert on mmdj_t to tiptop;

exit;
