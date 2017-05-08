/* 
================================================================================
檔案代號:nmao_t
檔案名稱:網銀交易類型檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table nmao_t
(
nmaoent       number(5)      ,/* 企業編號 */
nmao001       varchar2(15)      ,/* 網銀編號 */
nmao002       varchar2(40)      ,/* 交易類型編號 */
nmaostus       varchar2(1)      ,/* 狀態碼 */
nmaoownid       varchar2(20)      ,/* 資料所有者 */
nmaoowndp       varchar2(10)      ,/* 資料所屬部門 */
nmaocrtid       varchar2(20)      ,/* 資料建立者 */
nmaocrtdp       varchar2(10)      ,/* 資料建立部門 */
nmaocrtdt       timestamp(0)      ,/* 資料創建日 */
nmaomodid       varchar2(20)      ,/* 資料修改者 */
nmaomoddt       timestamp(0)      ,/* 最近修改日 */
nmao003       varchar2(1)      ,/* 分類一 */
nmao004       varchar2(1)      ,/* 分類二 */
nmaoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmaoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmaoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmaoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmaoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmaoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmaoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmaoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmaoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmaoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmaoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmaoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmaoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmaoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmaoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmaoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmaoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmaoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmaoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmaoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmaoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmaoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmaoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmaoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmaoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmaoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmaoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmaoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmaoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmaoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmao_t add constraint nmao_pk primary key (nmaoent,nmao001,nmao002) enable validate;

create unique index nmao_pk on nmao_t (nmaoent,nmao001,nmao002);

grant select on nmao_t to tiptop;
grant update on nmao_t to tiptop;
grant delete on nmao_t to tiptop;
grant insert on nmao_t to tiptop;

exit;
