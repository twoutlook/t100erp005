/* 
================================================================================
檔案代號:bxac_t
檔案名稱:保稅異動原因代碼檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bxac_t
(
bxacent       number(5)      ,/* 企業編號 */
bxacsite       varchar2(10)      ,/* 營運據點 */
bxac001       varchar2(10)      ,/* 保稅異動原因代碼 */
bxac002       varchar2(500)      ,/* 說明 */
bxac011       varchar2(1)      ,/* 是否須輸入報單號碼 */
bxac012       varchar2(1)      ,/* 是否須輸入廠內編號 */
bxac013       varchar2(1)      ,/* 是否須輸入放行單號 */
bxac014       varchar2(1)      ,/* 是否須輸入報單日期 */
bxac015       varchar2(1)      ,/* 是否須數入金額 */
bxac021       varchar2(10)      ,/* 庫存數量 */
bxac031       varchar2(10)      ,/* 保稅進口數 */
bxac032       varchar2(10)      ,/* 視同進口數 */
bxac033       varchar2(10)      ,/* 非保進口數 */
bxac041       varchar2(10)      ,/* 廠內生產領用數 */
bxac042       varchar2(10)      ,/* 廠外加工領用數 */
bxac043       varchar2(10)      ,/* 外運數 */
bxac044       varchar2(10)      ,/* 其他領用數 */
bxac045       varchar2(10)      ,/* 原料內銷數 */
bxac046       varchar2(10)      ,/* 原料外銷數 */
bxac047       varchar2(10)      ,/* 生產退料數 */
bxac048       varchar2(10)      ,/* 核准報廢數 */
bxac049       varchar2(10)      ,/* 調整數 */
bxac051       varchar2(10)      ,/* 成品存倉數 */
bxac052       varchar2(10)      ,/* 成品出倉數 */
bxac053       varchar2(10)      ,/* 直接出口數 */
bxac054       varchar2(10)      ,/* 視同出口數 */
bxac055       varchar2(10)      ,/* 內銷 */
bxac056       varchar2(10)      ,/* 其他出倉數 */
bxacownid       varchar2(20)      ,/* 資料所有者 */
bxacowndp       varchar2(10)      ,/* 資料所屬部門 */
bxaccrtid       varchar2(20)      ,/* 資料建立者 */
bxaccrtdp       varchar2(10)      ,/* 資料建立部門 */
bxaccrtdt       timestamp(0)      ,/* 資料創建日 */
bxacmodid       varchar2(20)      ,/* 資料修改者 */
bxacmoddt       timestamp(0)      ,/* 最近修改日 */
bxacstus       varchar2(10)      ,/* 狀態碼 */
bxacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxac_t add constraint bxac_pk primary key (bxacent,bxacsite,bxac001) enable validate;

create unique index bxac_pk on bxac_t (bxacent,bxacsite,bxac001);

grant select on bxac_t to tiptop;
grant update on bxac_t to tiptop;
grant delete on bxac_t to tiptop;
grant insert on bxac_t to tiptop;

exit;
