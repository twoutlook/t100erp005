/* 
================================================================================
檔案代號:deag_t
檔案名稱:門店收銀繳款單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table deag_t
(
deagent       number(5)      ,/* 企業編號 */
deagsite       varchar2(10)      ,/* 營運據點 */
deagunit       varchar2(10)      ,/* 應用組織 */
deagdocno       varchar2(20)      ,/* 單據編號 */
deagdocdt       date      ,/* 單據日期 */
deag001       varchar2(10)      ,/* 專櫃編號 */
deag002       varchar2(10)      ,/* 班別 */
deag003       varchar2(10)      ,/* 收銀機編號 */
deag004       varchar2(20)      ,/* 收銀員編號 */
deagownid       varchar2(20)      ,/* 資料所有者 */
deagowndp       varchar2(10)      ,/* 資料所屬部門 */
deagcrtid       varchar2(20)      ,/* 資料建立者 */
deagcrtdp       varchar2(10)      ,/* 資料建立部門 */
deagcrtdt       timestamp(0)      ,/* 資料創建日 */
deagmodid       varchar2(20)      ,/* 資料修改者 */
deagmoddt       timestamp(0)      ,/* 最近修改日 */
deagstus       varchar2(10)      ,/* 狀態碼 */
deagcnfid       varchar2(20)      ,/* 資料確認者 */
deagcnfdt       timestamp(0)      ,/* 資料確認日 */
deagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deagud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
deag005       varchar2(20)      ,/* 銀行存繳單號 */
deag006       varchar2(20)      /* 銀行收支單號 */
);
alter table deag_t add constraint deag_pk primary key (deagent,deagdocno) enable validate;

create unique index deag_pk on deag_t (deagent,deagdocno);

grant select on deag_t to tiptop;
grant update on deag_t to tiptop;
grant delete on deag_t to tiptop;
grant insert on deag_t to tiptop;

exit;
