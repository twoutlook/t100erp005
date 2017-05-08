/* 
================================================================================
檔案代號:xcab_t
檔案名稱:材料標準成本主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcab_t
(
xcabent       number(5)      ,/* 企業編號 */
xcabownid       varchar2(20)      ,/* 資料所有者 */
xcabowndp       varchar2(10)      ,/* 資料所屬部門 */
xcabcrtid       varchar2(20)      ,/* 資料建立者 */
xcabcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcabcrtdt       timestamp(0)      ,/* 資料創建日 */
xcabmodid       varchar2(20)      ,/* 資料修改者 */
xcabmoddt       timestamp(0)      ,/* 最近修改日 */
xcabstus       varchar2(10)      ,/* 狀態碼 */
xcabsite       varchar2(10)      ,/* 營運據點 */
xcab001       varchar2(10)      ,/* 版本 */
xcab002       varchar2(40)      ,/* 物料編碼 */
xcab003       varchar2(10)      ,/* 幣種 */
xcab004       number(20,6)      ,/* 材料標準單價 */
xcabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcab_t add constraint xcab_pk primary key (xcabent,xcab001,xcab002) enable validate;

create unique index xcab_pk on xcab_t (xcabent,xcab001,xcab002);

grant select on xcab_t to tiptop;
grant update on xcab_t to tiptop;
grant delete on xcab_t to tiptop;
grant insert on xcab_t to tiptop;

exit;
