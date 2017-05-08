/* 
================================================================================
檔案代號:stdk_t
檔案名稱:經銷商代墊費用報銷資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stdk_t
(
stdkent       number(5)      ,/* 企業編號 */
stdkunit       varchar2(10)      ,/* 應用組織 */
stdksite       varchar2(10)      ,/* 營運據點 */
stdkdocno       varchar2(20)      ,/* 單號編號 */
stdkdocdt       date      ,/* 單據日期 */
stdk001       varchar2(10)      ,/* 報銷類型 */
stdk002       varchar2(20)      ,/* 合約編號 */
stdk003       varchar2(10)      ,/* 經銷商編號 */
stdk004       varchar2(20)      ,/* 報銷人員 */
stdk005       varchar2(10)      ,/* 部門編號 */
stdk006       date      ,/* 開始日期 */
stdk007       date      ,/* 結束日期 */
stdk008       varchar2(10)      ,/* 幣別 */
stdk009       varchar2(10)      ,/* 稅別 */
stdk010       varchar2(10)      ,/* 聯繫人 */
stdk011       varchar2(80)      ,/* 聯繫電話 */
stdk012       varchar2(15)      ,/* 銀行編號 */
stdk013       varchar2(30)      ,/* 銀行卡號 */
stdkstus       varchar2(10)      ,/* 狀態碼 */
stdkownid       varchar2(20)      ,/* 資料所有者 */
stdkowndp       varchar2(10)      ,/* 資料所屬部門 */
stdkcrtid       varchar2(20)      ,/* 資料建立者 */
stdkcrtdp       varchar2(10)      ,/* 資料建立部門 */
stdkcrtdt       timestamp(0)      ,/* 資料創建日 */
stdkmodid       varchar2(20)      ,/* 資料修改者 */
stdkmoddt       timestamp(0)      ,/* 最近修改日 */
stdkcnfid       varchar2(20)      ,/* 資料確認者 */
stdkcnfdt       timestamp(0)      ,/* 資料確認日 */
stdkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stdkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stdkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stdkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stdkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stdkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stdkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stdkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stdkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stdkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stdkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stdkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stdkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stdkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stdkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stdkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stdkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stdkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stdkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stdkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stdkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stdkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stdkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stdkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stdkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stdkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stdkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stdkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stdkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stdkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stdk_t add constraint stdk_pk primary key (stdkent,stdkdocno) enable validate;

create unique index stdk_pk on stdk_t (stdkent,stdkdocno);

grant select on stdk_t to tiptop;
grant update on stdk_t to tiptop;
grant delete on stdk_t to tiptop;
grant insert on stdk_t to tiptop;

exit;
