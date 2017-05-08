/* 
================================================================================
檔案代號:nmar_t
檔案名稱:網銀公共配置設定明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmar_t
(
nmarent       number(5)      ,/* 企業編碼 */
nmar001       varchar2(10)      ,/* 接口網銀代碼 */
nmar002       varchar2(10)      ,/* 版本編號 */
nmar003       varchar2(10)      ,/* 交易類型 */
nmar004       varchar2(1)      ,/* 報文類型 */
nmar005       varchar2(1)      ,/* 資料類型 */
nmar006       number(5,0)      ,/* 序號 */
nmar007       varchar2(40)      ,/* 銀行字段名 */
nmar008       varchar2(40)      ,/* 中文說明 */
nmar009       varchar2(1)      ,/* 取值來源 */
nmar010       varchar2(40)      ,/* 固定值 */
nmar011       varchar2(15)      ,/* tiptop 表 */
nmar012       varchar2(10)      ,/* tiptop 取值字段 */
nmar013       varchar2(80)      ,/* 關聯條件 */
nmar014       varchar2(20)      ,/* 類型 */
nmar015       varchar2(1)      ,/* 是否必輸 */
nmar016       number(5,0)      ,/* 最大長度 */
nmar017       varchar2(1)      ,/* 不足需補字符 */
nmar018       varchar2(5)      ,/* 補何字符 */
nmar019       varchar2(10)      ,/* 補字符位置 */
nmar020       varchar2(1)      ,/* 是否控制小數位數 */
nmar021       number(5,0)      ,/* 小數位數 */
nmar022       varchar2(1)      ,/* 多域串 */
nmar023       varchar2(1)      ,/* 多域串分隔符號 */
nmar024       varchar2(100)      ,/* 備註 */
nmarstus       varchar2(1)      ,/* 有效碼 */
nmar025       varchar2(1)      ,/* 可重複否 */
nmarud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmarud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmarud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmarud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmarud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmarud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmarud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmarud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmarud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmarud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmarud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmarud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmarud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmarud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmarud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmarud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmarud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmarud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmarud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmarud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmarud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmarud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmarud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmarud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmarud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmarud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmarud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmarud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmarud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmarud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmar_t add constraint nmar_pk primary key (nmarent,nmar001,nmar002,nmar003,nmar004,nmar005,nmar006) enable validate;

create unique index nmar_pk on nmar_t (nmarent,nmar001,nmar002,nmar003,nmar004,nmar005,nmar006);

grant select on nmar_t to tiptop;
grant update on nmar_t to tiptop;
grant delete on nmar_t to tiptop;
grant insert on nmar_t to tiptop;

exit;
