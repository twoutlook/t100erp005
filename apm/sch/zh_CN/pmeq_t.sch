/* 
================================================================================
檔案代號:pmeq_t
檔案名稱:要貨模板基本資料單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmeq_t
(
pmeqent       number(5)      ,/* 企業編號 */
pmequnit       varchar2(10)      ,/* 應用組織 */
pmeq001       varchar2(10)      ,/* 要貨模板編號 */
pmeq002       varchar2(10)      ,/* 引用店群 */
pmeqownid       varchar2(20)      ,/* 資料所有者 */
pmeqowndp       varchar2(10)      ,/* 資料所屬部門 */
pmeqcrtid       varchar2(20)      ,/* 資料建立者 */
pmeqcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmeqcrtdt       timestamp(0)      ,/* 資料創建日 */
pmeqmodid       varchar2(20)      ,/* 資料修改者 */
pmeqmoddt       timestamp(0)      ,/* 最近修改日 */
pmeqstus       varchar2(10)      ,/* 狀態碼 */
pmequd001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmequd002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmequd003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmequd004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmequd005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmequd006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmequd007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmequd008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmequd009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmequd010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmequd011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmequd012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmequd013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmequd014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmequd015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmequd016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmequd017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmequd018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmequd019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmequd020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmequd021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmequd022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmequd023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmequd024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmequd025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmequd026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmequd027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmequd028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmequd029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmequd030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmeq_t add constraint pmeq_pk primary key (pmeqent,pmeq001) enable validate;

create unique index pmeq_pk on pmeq_t (pmeqent,pmeq001);

grant select on pmeq_t to tiptop;
grant update on pmeq_t to tiptop;
grant delete on pmeq_t to tiptop;
grant insert on pmeq_t to tiptop;

exit;
