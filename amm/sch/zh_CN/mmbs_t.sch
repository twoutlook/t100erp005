/* 
================================================================================
檔案代號:mmbs_t
檔案名稱:卡活動規則生效營運組織申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmbs_t
(
mmbsent       number(5)      ,/* 企業編號 */
mmbssite       varchar2(10)      ,/* 營運據點 */
mmbsunit       varchar2(10)      ,/* 應用組織 */
mmbsdocno       varchar2(20)      ,/* 單據編號 */
mmbs001       varchar2(30)      ,/* 活動規則編號 */
mmbs002       varchar2(10)      ,/* 規則類型 */
mmbs003       varchar2(10)      ,/* 卡種編號 */
mmbs004       varchar2(10)      ,/* 生效營運組織 */
mmbs005       varchar2(1)      ,/* 包含以下營運組織 */
mmbsacti       varchar2(1)      ,/* 有效 */
mmbsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbs_t add constraint mmbs_pk primary key (mmbsent,mmbsdocno,mmbs004) enable validate;

create unique index mmbs_pk on mmbs_t (mmbsent,mmbsdocno,mmbs004);

grant select on mmbs_t to tiptop;
grant update on mmbs_t to tiptop;
grant delete on mmbs_t to tiptop;
grant insert on mmbs_t to tiptop;

exit;
