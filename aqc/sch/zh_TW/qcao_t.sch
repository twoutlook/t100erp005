/* 
================================================================================
檔案代號:qcao_t
檔案名稱:品質檢驗判定結果檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table qcao_t
(
qcaoent       number(5)      ,/* 企業編號 */
qcao001       varchar2(5)      ,/* 參照表號 */
qcao002       varchar2(10)      ,/* 判定結果編號 */
qcao003       varchar2(10)      ,/* 判定區分 */
qcao004       varchar2(10)      ,/* IQC處理方式 */
qcao005       varchar2(1)      ,/* 成本倉 */
qcao006       varchar2(1)      ,/* 可用倉 */
qcao007       varchar2(1)      ,/* MRP可用倉 */
qcao008       varchar2(10)      ,/* 預設庫位 */
qcao009       varchar2(10)      ,/* 預設儲位 */
qcaoownid       varchar2(20)      ,/* 資料所有者 */
qcaoowndp       varchar2(10)      ,/* 資料所屬部門 */
qcaocrtid       varchar2(20)      ,/* 資料建立者 */
qcaocrtdp       varchar2(10)      ,/* 資料建立部門 */
qcaocrtdt       timestamp(0)      ,/* 資料創建日 */
qcaomodid       varchar2(20)      ,/* 資料修改者 */
qcaomoddt       timestamp(0)      ,/* 最近修改日 */
qcaostus       varchar2(10)      ,/* 狀態碼 */
qcaoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcaoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcaoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcaoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcaoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcaoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcaoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcaoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcaoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcaoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcaoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcaoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcaoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcaoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcaoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcaoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcaoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcaoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcaoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcaoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcaoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcaoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcaoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcaoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcaoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcaoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcaoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcaoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcaoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcaoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcao_t add constraint qcao_pk primary key (qcaoent,qcao001,qcao002) enable validate;

create unique index qcao_pk on qcao_t (qcaoent,qcao001,qcao002);

grant select on qcao_t to tiptop;
grant update on qcao_t to tiptop;
grant delete on qcao_t to tiptop;
grant insert on qcao_t to tiptop;

exit;
