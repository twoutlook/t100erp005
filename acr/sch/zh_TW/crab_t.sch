/* 
================================================================================
檔案代號:crab_t
檔案名稱:競爭廠商資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:Y
============.========================.==========================================
 */
create table crab_t
(
crabent       number(5)      ,/* 企業編號 */
crabunit       varchar2(10)      ,/* 應用組織 */
crab001       varchar2(10)      ,/* 競爭廠商編號 */
crab002       varchar2(20)      ,/* 統一編號 */
crab003       date      ,/* 創業日 */
crab004       varchar2(80)      ,/* 負責人 */
crab005       varchar2(20)      ,/* 身份證號 */
crab006       number(20,6)      ,/* 資本額 */
crab007       varchar2(10)      ,/* 資本額計算幣別 */
crab008       number(20,6)      ,/* 年營業額 */
crab009       varchar2(10)      ,/* 年營業額計算幣別 */
crab010       number(10,0)      ,/* 員工人數 */
crab011       varchar2(255)      ,/* 營業項目 */
crab012       varchar2(20)      ,/* 聯絡對象識別碼 */
crabacti       varchar2(10)      ,/* 資料有效 */
crabstus       varchar2(10)      ,/* 資料狀態碼 */
crabownid       varchar2(20)      ,/* 資料所有者 */
crabowndp       varchar2(10)      ,/* 資料所屬部門 */
crabcrtid       varchar2(20)      ,/* 資料建立者 */
crabcrtdp       varchar2(10)      ,/* 資料建立部門 */
crabcrtdt       timestamp(0)      ,/* 資料創建日 */
crabmodid       varchar2(20)      ,/* 資料修改者 */
crabmoddt       timestamp(0)      ,/* 最近修改日 */
crabcnfid       varchar2(20)      ,/* 資料確認者 */
crabcnfdt       timestamp(0)      ,/* 資料確認日 */
crabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crab_t add constraint crab_pk primary key (crabent,crab001) enable validate;

create unique index crab_pk on crab_t (crabent,crab001);

grant select on crab_t to tiptop;
grant update on crab_t to tiptop;
grant delete on crab_t to tiptop;
grant insert on crab_t to tiptop;

exit;
