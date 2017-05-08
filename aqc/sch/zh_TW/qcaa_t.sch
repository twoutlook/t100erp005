/* 
================================================================================
檔案代號:qcaa_t
檔案名稱:一般檢驗水準樣本代碼檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table qcaa_t
(
qcaastus       varchar2(10)      ,/* 狀態碼 */
qcaaent       number(5)      ,/* 企業編號 */
qcaa001       number(10,0)      ,/* 起始批量 */
qcaa002       number(10,0)      ,/* 截止批量 */
qcaa003       varchar2(10)      ,/* 級數 */
qcaa004       varchar2(1)      ,/* 樣本編號 */
qcaa005       number(5,0)      ,/* no use */
qcaa006       number(5,0)      ,/* no use */
qcaa007       number(5,0)      ,/* no use */
qcaaownid       varchar2(20)      ,/* 資料所有者 */
qcaaowndp       varchar2(10)      ,/* 資料所屬部門 */
qcaacrtid       varchar2(20)      ,/* 資料建立者 */
qcaacrtdp       varchar2(10)      ,/* 資料建立部門 */
qcaacrtdt       timestamp(0)      ,/* 資料創建日 */
qcaamodid       varchar2(20)      ,/* 資料修改者 */
qcaamoddt       timestamp(0)      ,/* 最近修改日 */
qcaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcaa_t add constraint qcaa_pk primary key (qcaaent,qcaa001,qcaa002,qcaa003,qcaa004) enable validate;

create unique index qcaa_pk on qcaa_t (qcaaent,qcaa001,qcaa002,qcaa003,qcaa004);

grant select on qcaa_t to tiptop;
grant update on qcaa_t to tiptop;
grant delete on qcaa_t to tiptop;
grant insert on qcaa_t to tiptop;

exit;
