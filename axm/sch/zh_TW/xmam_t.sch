/* 
================================================================================
檔案代號:xmam_t
檔案名稱:包裝方式檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmam_t
(
xmament       number(5)      ,/* 企業編號 */
xmam001       varchar2(10)      ,/* 包裝方式 */
xmam003       varchar2(10)      ,/* 包裝規格 */
xmam004       varchar2(40)      ,/* 包裝容器 */
xmam005       number(20,6)      ,/* 長面個數 */
xmam006       number(20,6)      ,/* 寬面個數 */
xmam007       number(20,6)      ,/* 高面個數 */
xmam008       number(20,6)      ,/* 總包裝數 */
xmam009       varchar2(10)      ,/* 包裝單位 */
xmam010       number(20,6)      ,/* 包裝容器長度 */
xmam011       number(20,6)      ,/* 包裝容器寬度 */
xmam012       number(20,6)      ,/* 包裝容器高度 */
xmam013       number(20,6)      ,/* 總體積 */
xmam014       varchar2(10)      ,/* 長度單位 */
xmam015       number(20,6)      ,/* 包裝容器重量 */
xmam016       varchar2(10)      ,/* 重量單位 */
xmam017       varchar2(1)      ,/* 是否有內包裝 */
xmam018       varchar2(10)      ,/* 內包裝方式 */
xmam019       varchar2(10)      ,/* 體積單位 */
xmamownid       varchar2(20)      ,/* 資料所有者 */
xmamowndp       varchar2(10)      ,/* 資料所屬部門 */
xmamcrtid       varchar2(20)      ,/* 資料建立者 */
xmamcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmamcrtdt       timestamp(0)      ,/* 資料創建日 */
xmammodid       varchar2(20)      ,/* 資料修改者 */
xmammoddt       timestamp(0)      ,/* 最近修改日 */
xmamstus       varchar2(10)      ,/* 狀態碼 */
xmamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmamud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmam_t add constraint xmam_pk primary key (xmament,xmam001) enable validate;

create unique index xmam_pk on xmam_t (xmament,xmam001);

grant select on xmam_t to tiptop;
grant update on xmam_t to tiptop;
grant delete on xmam_t to tiptop;
grant insert on xmam_t to tiptop;

exit;
