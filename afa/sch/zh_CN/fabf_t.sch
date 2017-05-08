/* 
================================================================================
檔案代號:fabf_t
檔案名稱:資產變更歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fabf_t
(
fabfent       number(5)      ,/* 企業編號 */
fabf001       varchar2(10)      ,/* 卡片編號 */
fabf002       varchar2(20)      ,/* 財產編號 */
fabf003       varchar2(20)      ,/* 附號 */
fabf004       number(10,0)      ,/* 變更序 */
fabf005       varchar2(20)      ,/* 變更欄位 */
fabf006       varchar2(255)      ,/* 變更前內容 */
fabf007       varchar2(255)      ,/* 變更後內容 */
fabf008       varchar2(80)      ,/* 最後變更時間 */
fabf009       varchar2(500)      ,/* 欄位說明SQL */
fabfownid       varchar2(20)      ,/* 資料所有者 */
fabfowndp       varchar2(10)      ,/* 資料所屬部門 */
fabfcrtid       varchar2(20)      ,/* 資料建立者 */
fabfcrtdp       varchar2(10)      ,/* 資料建立部門 */
fabfcrtdt       timestamp(0)      ,/* 資料創建日 */
fabfmodid       varchar2(20)      ,/* 資料修改者 */
fabfmoddt       timestamp(0)      ,/* 最近修改日 */
fabfcnfid       varchar2(20)      ,/* 資料確認者 */
fabfcnfdt       timestamp(0)      ,/* 資料確認日 */
fabfpstid       varchar2(20)      ,/* 資料過帳者 */
fabfpstdt       timestamp(0)      ,/* 資料過帳日 */
fabfstus       varchar2(10)      ,/* 狀態碼 */
fabfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fabf_t add constraint fabf_pk primary key (fabfent,fabf001,fabf002,fabf003,fabf004,fabf005) enable validate;

create unique index fabf_pk on fabf_t (fabfent,fabf001,fabf002,fabf003,fabf004,fabf005);

grant select on fabf_t to tiptop;
grant update on fabf_t to tiptop;
grant delete on fabf_t to tiptop;
grant insert on fabf_t to tiptop;

exit;
