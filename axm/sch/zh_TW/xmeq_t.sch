/* 
================================================================================
檔案代號:xmeq_t
檔案名稱:地磅單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmeq_t
(
xmeqent       number(5)      ,/* 企業編號 */
xmeqsite       varchar2(10)      ,/* 營運據點 */
xmeqdocno       varchar2(20)      ,/* 地磅單號 */
xmeqseq       number(10,0)      ,/* 次數 */
xmeq001       number(20,6)      ,/* 重量 */
xmeq002       varchar2(10)      ,/* 單位 */
xmeq003       date      ,/* 日期 */
xmeq004       varchar2(8)      ,/* 時間 */
xmequd001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmequd002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmequd003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmequd004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmequd005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmequd006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmequd007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmequd008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmequd009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmequd010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmequd011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmequd012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmequd013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmequd014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmequd015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmequd016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmequd017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmequd018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmequd019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmequd020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmequd021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmequd022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmequd023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmequd024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmequd025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmequd026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmequd027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmequd028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmequd029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmequd030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmeq_t add constraint xmeq_pk primary key (xmeqent,xmeqdocno,xmeqseq) enable validate;

create unique index xmeq_pk on xmeq_t (xmeqent,xmeqdocno,xmeqseq);

grant select on xmeq_t to tiptop;
grant update on xmeq_t to tiptop;
grant delete on xmeq_t to tiptop;
grant insert on xmeq_t to tiptop;

exit;
