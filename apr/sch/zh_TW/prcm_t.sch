/* 
================================================================================
檔案代號:prcm_t
檔案名稱:促銷任務量分配資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prcm_t
(
prcment       number(5)      ,/* 企業編號 */
prcmunit       varchar2(10)      ,/* 應用組織 */
prcmsite       varchar2(10)      ,/* 營運據點 */
prcmdocno       varchar2(20)      ,/* 單據編號 */
prcmdocdt       date      ,/* 單據日期 */
prcm001       varchar2(30)      ,/* 促銷方案 */
prcm002       varchar2(30)      ,/* 活動計劃 */
prcm003       varchar2(20)      ,/* 分配人員 */
prcm004       varchar2(10)      ,/* 分配部門 */
prcm005       varchar2(255)      ,/* 備註 */
prcmstus       varchar2(10)      ,/* 狀態碼 */
prcmownid       varchar2(20)      ,/* 資料所有者 */
prcmowndp       varchar2(10)      ,/* 資料所屬部門 */
prcmcrtid       varchar2(20)      ,/* 資料建立者 */
prcmcrtdp       varchar2(10)      ,/* 資料建立部門 */
prcmcrtdt       timestamp(0)      ,/* 資料創建日 */
prcmmodid       varchar2(20)      ,/* 資料修改者 */
prcmmoddt       timestamp(0)      ,/* 最近修改日 */
prcmcnfid       varchar2(20)      ,/* 資料確認者 */
prcmcnfdt       timestamp(0)      ,/* 資料確認日 */
prcmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prcmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prcmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prcmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prcmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prcmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prcmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prcmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prcmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prcmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prcmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prcmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prcmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prcmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prcmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prcmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prcmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prcmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prcmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prcmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prcmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prcmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prcmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prcmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prcmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prcmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prcmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prcmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prcmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prcmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prcm_t add constraint prcm_pk primary key (prcment,prcmdocno) enable validate;

create unique index prcm_pk on prcm_t (prcment,prcmdocno);

grant select on prcm_t to tiptop;
grant update on prcm_t to tiptop;
grant delete on prcm_t to tiptop;
grant insert on prcm_t to tiptop;

exit;
