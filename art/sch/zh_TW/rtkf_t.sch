/* 
================================================================================
檔案代號:rtkf_t
檔案名稱:門店商品自動補貨參數檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table rtkf_t
(
rtkfent       number(5)      ,/* 企業編號 */
rtkfunit       varchar2(10)      ,/* 應用組織 */
rtkf001       varchar2(10)      ,/* 門店編號 */
rtkf002       varchar2(40)      ,/* 商品編號 */
rtkf003       varchar2(10)      ,/* 庫存單位 */
rtkf004       varchar2(10)      ,/* 採購方式 */
rtkf005       varchar2(10)      ,/* 主供應商 */
rtkf006       number(5,0)      ,/* 目標庫存天數 */
rtkf007       number(5,0)      ,/* 安全庫存天數 */
rtkf008       number(5,0)      ,/* 最小庫存天數 */
rtkf009       number(20,6)      ,/* 最小庫存數量 */
rtkf010       number(15,3)      ,/* DMS */
rtkf011       number(15,3)      ,/* 促銷PDMS */
rtkfstus       varchar2(10)      ,/* 狀態碼 */
rtkfownid       varchar2(20)      ,/* 資料所有者 */
rtkfowndp       varchar2(10)      ,/* 資料所屬部門 */
rtkfcrtid       varchar2(20)      ,/* 資料建立者 */
rtkfcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtkfcrtdt       timestamp(0)      ,/* 資料創建日 */
rtkfmodid       varchar2(20)      ,/* 資料修改者 */
rtkfmoddt       timestamp(0)      ,/* 最近修改日 */
rtkfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtkfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtkfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtkfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtkfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtkfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtkfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtkfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtkfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtkfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtkfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtkfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtkfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtkfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtkfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtkfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtkfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtkfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtkfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtkfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtkfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtkfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtkfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtkfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtkfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtkfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtkfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtkfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtkfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtkfud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtkf012       timestamp(0)      /* 最近推算日期 */
);
alter table rtkf_t add constraint rtkf_pk primary key (rtkfent,rtkf001,rtkf002) enable validate;

create unique index rtkf_pk on rtkf_t (rtkfent,rtkf001,rtkf002);

grant select on rtkf_t to tiptop;
grant update on rtkf_t to tiptop;
grant delete on rtkf_t to tiptop;
grant insert on rtkf_t to tiptop;

exit;
